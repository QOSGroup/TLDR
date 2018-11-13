# go modules 与 goproxy 使用简介

* [go modules](https://github.com/golang/go/wiki/Modules)

* ecosystem

  * [goproxy](https://github.com/goproxyio/goproxy)

  * [athens](https://github.com/gomods/athens/)

### go modules 简介

Go 1.11 版本开始正式引入官方依赖管理工具go modules,

go modules 会对版本进行管理，其管理的代码存放地址不再是之前的 $GOPATH/src，而是变为 $GOPATH/pkg/mod.

并且会在保存代码的路径直接保留版本信息，以便更精确的管理代码版本，并且可以同时管理多个代码版本。

```
$> ll $GOPATH/pkg/mod/github.com/spf13/  

$GOPATH/pkg/mod/github.com/spf13/cobra@v0.0.1  
$GOPATH/pkg/mod/github.com/spf13/viper@v0.0.0-20170723055207-25b30aa063fc  
$GOPATH/pkg/mod/github.com/spf13/viper@v1.0.0  
```

默认情况下，go modules 会忽略 vendor/ 目录。但可以通过命令将依赖代码导出到vendor/ 目录，以便需要vendor/ 时使用。

同时，go modules 还支持了一个大部分项目需要的特性：go porxy，即可以设置代理作为整体项目的go 代码的私库。

这样可以大大提高效率，因为其可以提高代码依赖下载的速度，同时提高了编译集成等操作的成功率。

### goproxyio/goproxy 简介

项目地址：https://github.com/goproxyio/goproxy

目前环境搭建的go proxy 为 goproxyio/goproxy，已部署试用。

经初步测试似乎仍有一些问题（但不影响目前的使用）：

* 代理服务端和客户端似乎都仅支持go modules 模式，其他情况无法正常下载代码；

* go modules 下载代理服务器没有的项目代码版本时，不能自动下载，需要人工登录代理服务器手动下载，维护管理相对繁琐；

* 更新维护较慢。

### gomods/athens 简介

项目地址：https://github.com/gomods/athens/

为了解决试用 goproxyio/goproxy 中出现的问题，考虑试用 gomods/athens，另一个 go 代码代理的实现方案。

看相关介绍似乎解决了上面 goproxyio/goproxy 的问题，而且维护更新较快。

### 配置使用简介

* 1 首先需要安装go 1.11 版本，因为 go modules 是在 go1.11 加入的新特性。

* 2 配置环境变量

> export GO111MODULE=on  
> export GOPROXY=http://192.168.1.176:8081  

* 3 使用 go modules

> \# 初始化  
> \# 在已有项目（但不存在go.mod 文件）中执行,或在空目录中执行  
> go mod init  
> \# 或 
> go mode init examples.com/m 

目录中会创建 go.mod 文件，如果项目中已有代码，则会自动判断依赖项目以及版本，如下：

```
module examples.com/m
```

如果项目目录中存在如下代码：

```
package main

import (
        "fmt"

        _ "google.golang.org/grpc"
)

func main() {
        fmt.Println("Ok.")
}
```

执行 go build 编译，会自动下载依赖，并判断版本以及更新 go.mod：

```
module examples.com/m

require google.golang.org/grpc v1.15.0
```

执行编译时的输出日志，会下载相关依赖并完成编译。

```
$> go build

go: finding google.golang.org/grpc v1.15.0
go: finding github.com/golang/lint v0.0.0-20180702182130-06c8688daad7
go: finding golang.org/x/sys v0.0.0-20180830151530-49385e6e1522
go: finding github.com/client9/misspell v0.3.4
go: finding github.com/golang/mock v1.1.1
go: finding github.com/kisielk/gotool v1.0.0
go: finding github.com/golang/protobuf v1.2.0
go: finding google.golang.org/appengine v1.1.0
go: finding cloud.google.com/go v0.26.0
go: finding golang.org/x/net v0.0.0-20180826012351-8a410e7b638d
go: finding golang.org/x/lint v0.0.0-20180702182130-06c8688daad7
go: finding golang.org/x/tools v0.0.0-20180828015842-6cd1fcedba52
go: finding google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8
go: finding honnef.co/go/tools v0.0.0-20180728063816-88497007e858
go: finding github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b
go: finding golang.org/x/oauth2 v0.0.0-20180821212333-d2e6202438be
go: finding golang.org/x/text v0.3.0
go: finding golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f
go: downloading google.golang.org/grpc v1.15.0
go: downloading golang.org/x/net v0.0.0-20180826012351-8a410e7b638d
go: downloading google.golang.org/genproto v0.0.0-20180817151627-c66870c02cf8
go: downloading github.com/golang/protobuf v1.2.0
go: downloading golang.org/x/sys v0.0.0-20180830151530-49385e6e1522
go: downloading golang.org/x/text v0.3.0
```

