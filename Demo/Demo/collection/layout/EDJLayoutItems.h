//
//  EDJLayoutItems.h
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EDJLayoutItem.h"

@interface EDJLayoutItems : NSObject
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, strong) NSMutableArray <EDJLayoutItem *> *attributes;
@end

