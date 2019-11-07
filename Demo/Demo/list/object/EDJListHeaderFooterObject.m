//
//  EDJListHeaderFooterObject.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListHeaderFooterObject.h"
#import "EDJListHeaderFooterView.h"

@implementation EDJListHeaderFooterObject

- (CGFloat)height{
    return 20;
}

- (Class)viewClass{
    return [EDJListHeaderFooterView class];
}

@end
