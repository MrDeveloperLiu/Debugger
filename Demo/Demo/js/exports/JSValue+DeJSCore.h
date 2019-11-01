//
//  JSValue+Call.h
//  Demo
//
//  Created by 刘杨 on 2019/7/10.
//  Copyright © 2019 liu. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSValue (DeJSCore)
- (JSValue *)callVoid;
- (JSValue *)call:(NSArray *)arguments;

- (JSValue *)instance:(NSString *)name;
- (JSValue *)function:(NSString *)name;

- (JSValue *)callInstanceFunction:(NSString *)function;
- (JSValue *)callInstanceFunction:(NSString *)function arguments:(NSArray *)arguments;
@end

