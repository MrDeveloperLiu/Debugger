//
//  DifferentImplViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DifferentImplViewController.h"

@interface DifferentImplViewController ()

@end

@implementation DifferentImplViewController

- (instancetype)initWithDifferentImpl:(id<DifferentImplProtocol>)impl{
    self = [super init];
    _impl = impl;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn = [_impl centerButton];
    [btn addTarget:_impl action:@selector(doIt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn.width = 100;
    btn.height = 50;
    btn.center = self.view.center;
}


@end
