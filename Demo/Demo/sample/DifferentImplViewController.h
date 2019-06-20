//
//  DifferentImplViewController.h
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DifferentImplProtocol.h"
#import "DifferentColorImpl.h"
#import "DifferentHiddenImpl.h"


@interface DifferentImplViewController : UIViewController
@property (nonatomic, strong, readonly) id <DifferentImplProtocol> impl;
- (instancetype)initWithDifferentImpl:(id<DifferentImplProtocol>)impl;
@end


