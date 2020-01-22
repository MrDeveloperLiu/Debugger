# Debugger
前言：一个好的程序猿，应该有自己的库，即使是随便写着玩，也是有意义的

* 网络库 DeHTTPManager
* 你可以这样使用它
```js 
self.manager = [DeHTTPManager manager];
NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
NSDictionary *paramters = @{@"1" : @"中文"};
[self.manager requestWithBaseUrl:url method:@"POST" paramters:paramters successBlock:^(DeHTTPDataTask *task, NSURLResponse *response, id data) {
    NSLog(@"success: %@", data);
} failedBlock:^(DeHTTPDataTask *task, NSURLResponse *response, NSError *error) {
    if (task.isCanceled) {
        NSLog(@"canceled: %@", error);
    }else{
        NSLog(@"failed: %@", error);
    }
}];
```

* 函数响应式编程（FRP） DeReact
mvvm轻量化解决方案, 本功能参照ReactCocoa-Objc，你可以很优雅的写出一段当输入框改变时，订阅事件
```js
__weak __typeof(self) ws = self;

DeDispose *disponse =
[[self.textField.de_textSignal map:^id(UITextField *x) {
    return x.text;
}] subscribeNext:^(id x) {
    ws.textView.text = x;
}];
[self.deallocDispose addDispose:disponse];

```


* 其他功能 
1. XML解析器 DeSimpleXMLParaser
2. 代理类 DeProxy 
3. 日志类 DeFileLogger
