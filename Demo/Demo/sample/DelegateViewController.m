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

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"I Hate" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn.width = 100;
    btn.height = 50;
    btn.center = self.view.center;
}

- (void)btnAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate delegateViewController:self hatesThatBlock:YES];
}

@end
