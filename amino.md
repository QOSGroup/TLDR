# go-amino使用

##简单使用:
1.创建CodeC实例
```
cdc:= codec.New()
```
2.初始化，涉及接口方式反序列化，注册接口和实现
```
//固定形式
cdc.RegisterInterface((*Interface)(nil), nil)
//指针或非指针都支持，统一指针方式
cdc.RegisterConcrete(&Concrete{}, "pakageName/structName", nil)

```
3.使用
```
cdc.Marshal***/Unmarshal***
```
##使用原则:
1.顶层定义全局codec包，定义codec.go
```
//主要提供New()方法
func New() *Codec {
	cdc := amino.NewCodec()
	return cdc
}
```
2.包内序列化反序列化：
```
//包内创建codec.go
var cdc = codec.New()
//涉及到接口方式反序列化需要注册相应接口和实现
func init() {
  cdc.RegisterInterface((*Account)(nil), nil)
  cdc.RegisterConcrete(&BaseAccount{}, "auth/Account", nil)
}
```
3.包内数据结构外部有涉及序列化反序列化：
```
//提供如下方法，外部调用即可（全局注册，codec参数传递方式）
func RegisterCodec(cdc *codec.Codec) {
    cdc.RegisterInterface((*Account)(nil), nil)
    cdc.RegisterConcrete(&BaseAccount{}, "auth/Account", nil)
    cdc.RegisterConcrete(StdTx{}, "auth/StdTx", nil)
}
```

##特别注意
1.参照tendermint/cosmos既定使用原则
2.参与序列化/反序列化字段大写字母开头
3.编解码用统一编码格式(JSON/Binary)，统一编解码方法(JSON/Binary/BinaryBare)
4.处理类在编解码codec中注册/未注册状态统一
5.float 添加`amino:unsafe`,json解码时错误，避免使用
6.enmu 序列化为int
7.map JSON序列化支持，Binary会panic，不涉及序列化反序列化Binary的情况可用