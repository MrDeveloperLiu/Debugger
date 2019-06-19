//
//  TextFiledViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "TextFiledViewController.h"


@interface TextFiledViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextFiledViewController

- (void)dealloc{
    NSLog(@"检测内存：%@", [DeDebugRefCount ref]);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Search";
    
    UIView *v = [UIView new]; v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    //链式
    v.de_width(self.view.width)
    .de_height(60)
    .de_centerX(self.view.centerX)
    .de_bottom(self.view.bottom - 10);

    //fuck !  it's very comfortable
    __weak __typeof(self) ws = self;
    
    DeSignal *signal = [[self.textField.de_textSignal map:^id(UITextField *x) {
        return x.text;
    }] filter:^BOOL(NSString *x) {
        if (x.length <= 0) {
            ws.textView.text = @"请输入检索内容";
            return YES;
        }
        return NO;
    }];
    DeDispose *disponse = [signal subscribeNext:^(id x) {
        ws.textView.text = [NSString stringWithFormat:@"检索：%@", x];
    }];
    [self.deallocDispose addDispose:disponse];
}


@end
