//
//  TextFiledViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "TextFiledViewController.h"
#import "UIControl+DeReact.h"

@interface TextFiledViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextFiledViewController

- (void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    //fuck !  it's very comfortable
    __weak __typeof(self) ws = self;
    
    DeDispose *disponse =
    [[self.textField.de_textSignal map:^id(UITextField *x) {
        return x.text;
    }] subscribeNext:^(id x) {
        ws.textView.text = x;
    }];
    [self.deallocDispose addDispose:disponse];
}

@end
