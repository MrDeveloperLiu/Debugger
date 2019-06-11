# Debugger
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


