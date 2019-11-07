//
//  DeAppWindow.h
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeJavaScriptCore;
@interface DeAppWindow : UIWindow
@property (nonatomic, assign, readonly) BOOL animated;
@property (nonatomic, assign, readonly) BOOL visiable;

@property (nonatomic, weak) DeJavaScriptCore *jvm;

- (instancetype)initWithRootViewController:(UIViewController *)vc;

- (void)show;
- (void)dismiss:(dispatch_block_t)animation completion:(dispatch_block_t)completion;
- (void)transformToBottom;
@end

