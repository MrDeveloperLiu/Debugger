//
//  JSContext+DeJSCore.h
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@interface JSContext (DeJSCore)
- (void)registerExportClass:(NSString *)clsname cls:(Class)cls;
- (void)registerFunction:(NSString *)funcname block:(id)block;
- (void)registerInstance:(NSString *)name instance:(id)instance;

- (JSValue *)instance:(NSString *)name;
- (JSValue *)function:(NSString *)name;

- (JSValue *)loadJsFile:(NSString *)filename inBundle:(NSBundle *)bundle;
@end
