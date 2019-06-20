//
//  DifferentColorImpl.m
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DifferentColorImpl.h"

@implementation DifferentColorImpl
{
    __weak UIButton *_btn;
}


- (UIButton *)centerButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Hidden It" forState:UIControlStateNormal];
    _btn = btn;
    return btn;
}

- (void)doIt:(id)sender{
    _btn.backgroundColor = [UIColor cyanColor];
}

@end
