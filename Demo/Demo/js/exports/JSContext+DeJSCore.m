//
//  JSContext+DeJSCore.m
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import "JSContext+DeJSCore.h"

@implementation JSContext (DeJSCore)

- (void)registerExportClass:(NSString *)clsname cls:(Class)cls{
    NSParameterAssert(clsname); NSParameterAssert(cls);
    self[clsname] = cls;
}

- (void)registerFunction:(NSString *)funcname block:(id)block{
    NSParameterAssert(funcname); NSParameterAssert(block);
    self[funcname] = block;
}

- (void)registerInstance:(NSString *)name instance:(id)instance{
    NSParameterAssert(name); NSParameterAssert(instance);
    self[name] = instance;
}

- (JSValue *)instance:(NSString *)name{
    NSParameterAssert(name);
    return self[name];
}

- (JSValue *)function:(NSString *)name{
    NSParameterAssert(name);
    return self[name];
}

- (JSValue *)loadJsFile:(NSString *)filename inBundle:(NSBundle *)bundle{
    NSParameterAssert(filename);
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSString *file = [bundle pathForResource:filename ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:file];
    NSString *script = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return [self evaluateScript:script];
}
@end
