//
//  EDJListObjects.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDJListObject.h"
#import "EDJListHeaderFooterObject.h"

@interface EDJListObjects : NSObject
@property (nonatomic, assign) NSUInteger section;

@property (nonatomic, strong) EDJListHeaderFooterObject *header;
@property (nonatomic, strong) EDJListHeaderFooterObject *footer;
@property (nonatomic, strong) NSMutableArray <EDJListObject *> *cells;
@end

