# 单元测试覆盖率分析工具
单元测试覆盖率是基于go test工具生成的，为方便使用，写了个shell小工具，可以直接在包的目录下运行，然后通过浏览器查看覆盖率。

## 安装
  下载
```
$sudo wget https://raw.githubusercontent.com/QOSGroup/TLDR/master/scripts/ct.sh -O /usr/local/bin/ct.sh
$sudo chmod +x /usr/local/bin/ct.sh
```

## 使用
  进入需要分析覆盖率的目录下，直接运行ct.sh
```
$cd qstars
$ct.sh
PASS
coverage: 0.0% of statements
ok      git.qoschain.io/QOSGroup/qstars 0.009s

Launching browser on http://testing.qos.com/unit/cover.html
```
  在浏览器打开http://testing.qos.com/unit/cover.html，即可查看结果。
  
  忽略.cover目录，该工具会创建.cover目录，防止误将.cover提交到git repo，需要忽略该文件夹
  ```
  //打开项目.gitignore，在repo根目录，在合适的位置增加*.cover
  $vim .gitignore
  *.cover
  $git add .gitignore
  $git commit -m "Ignore .cover directory created by cover analysis tool"
  $git push
  ```

## 注意
  如果单元测试失败，不能运行覆盖率分析，必须跑通单元测试。
  如果包比较大，测试用例很多，可能需要等几分钟，需要等单元测试跑完。

# 单元测试
```
//运行单元测试
$go test

//查看单元测试用例
$go test -list Test

//执行指定单元测试用例，正则匹配xxx
$go test -run xxx
```
