//
//  DeAppWindow.m
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeAppWindow.h"
#import "DeJavaScriptCore.h"

@interface DeAppWindow ()
@property (nonatomic, strong) id appInfo;
@end

@implementation DeAppWindow

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithRootViewController:(UIViewController *)vc{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self = [super initWithFrame:frame];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    self.rootViewController = navigation;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appEnterBg:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appEnterFg:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    
    return self;
}

- (void)_appEnterBg:(NSNotification *)notify{
    JSValue *applicationIvar = [_jvm.jsContext instance:@"application"];
    [applicationIvar callInstanceFunction:@"applicationDidEnterBackground"];
}

- (void)_appEnterFg:(NSNotification *)notify{
    JSValue *applicationIvar = [_jvm.jsContext instance:@"application"];
    [applicationIvar callInstanceFunction:@"applicationDidEnterForeground"];
}

- (void)_appTerminate:(NSNotification *)notify{
    JSValue *applicationIvar = [_jvm.jsContext instance:@"application"];
    [applicationIvar callInstanceFunction:@"applicationWillTerminate"];
}

- (void)finishLoadApp{
    JSValue *applicationIvar = [_jvm.jsContext instance:@"application"];
    JSValue *appInfoIvar = [applicationIvar instance:@"information"];
    self.appInfo = [appInfoIvar toObject];
    
    NSMutableDictionary *option = [@{} mutableCopy];
    option[@"token"] = @"a1b2bc3";
    [applicationIvar callInstanceFunction:@"applicationDidFinishedLauchedWithOptions" arguments:@[option]];
}
- (void)stopApp{
    JSValue *applicationIvar = [_jvm.jsContext instance:@"application"];
    [applicationIvar callInstanceFunction:@"applicationDidStop"];
}

- (void)show{
    if (_visiable) {
        return;
    }
    [self makeKeyAndVisible];
    _visiable = YES;
    [self pushAnimation];
    
    [self finishLoadApp];
}

- (void)pushAnimation{
    CATransition *a = [CATransition animation];
    a.type = kCATransitionPush;
    a.subtype = kCATransitionFromTop;
    a.duration = 0.3;
    [self.layer addAnimation:a forKey:@"push"];
}

- (void)dismiss:(dispatch_block_t)animation completion:(dispatch_block_t)completion{
    if (!_visiable || _animated) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self transformToBottom];
    } completion:^(BOOL finished) {
        [self transformDone];
        if (completion) completion();
    }];
    _animated = YES;
    if (animation) animation();
}

- (void)transformToBottom{
    self.transform = CGAffineTransformMakeTranslation(0, self.bottom);
}

- (void)transformDone{
    _visiable = NO;
    _animated = NO;
    [self stopApp];
    [self resignKeyWindow];
}

@end
