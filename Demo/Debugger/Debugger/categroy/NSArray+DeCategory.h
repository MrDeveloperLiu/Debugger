//
//  NSArray+DeCategory.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSArray (DeCategory)
- (NSInteger)_deFirstIndex;
- (NSInteger)_deLastIndex;

- (BOOL)_deSafetyIndex:(NSInteger)index;
- (id)deObjectAtIndex:(NSInteger)index;
@end


@interface NSMutableArray (DeCategory)
- (void)deAddObject:(id)object;
- (void)deInsertObject:(id)object atIndex:(NSUInteger)index;
@end
