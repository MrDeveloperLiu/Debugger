//
//  DifferentImplProtocol.h
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DifferentImplProtocol <NSObject>

- (UIButton *)centerButton;

- (void)doIt:(id)sender;

@end

