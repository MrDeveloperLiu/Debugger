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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"Search";

    //fuck !  it's very comfortable
    __weak __typeof(self) ws = self;
    
    DeDispose *disponse = [[[self.textField.de_textSignal map:^id(UITextField *x) {
        return x.text;
    }] filter:^BOOL(NSString *x) {
        if (x.length <= 0) {
            ws.textView.text = @"请输入检索内容";
            return YES;
        }
        return NO;
    }] subscribeNext:^(id x) {
        ws.textView.text = [NSString stringWithFormat:@"检索：%@", x];
    }];
    [self.deallocDispose addDispose:disponse];
}


@end
