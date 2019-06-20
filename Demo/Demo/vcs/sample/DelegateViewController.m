//
//  DelegateViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DelegateViewController.h"

@interface DelegateViewController ()

@end

@implementation DelegateViewController

- (void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"I Hate" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn.width = 100;
    btn.height = 50;
    btn.center = self.view.center;
    
    
    NSDictionary *paramters = @{@"1" : @"中文", @"2" : @"English"};
    DeDispose *dispose = [[APP de_networkSignal:@"https://www.baidu.com" method:kHTTPMethodPOST parameters:paramters] subscribeNext:^(id x) {
        NSLog(@"net: %@", x);
    } error:^(NSError *error) {
        NSLog(@"net: %@", error);
    } completed:^{
        NSLog(@"net complete");
    }];
    [self.deallocDispose addDispose:dispose];
}

- (void)btnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate delegateViewController:self hatesThatBlock:YES];
}

@end
