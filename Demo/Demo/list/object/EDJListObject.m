//
//  EDJListObject.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListObject.h"
#import "EDJListViewCell.h"

@implementation EDJListObject
- (CGFloat)rowHeight{
    return 44;
}
- (Class)viewClass{
    return [EDJListViewCell class];
}
@end
