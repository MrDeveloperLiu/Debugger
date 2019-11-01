//
//  NSArray+EDJTransformable.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTransformable.h"

typedef id(^EDJTransformableBlock)(id object);
typedef id(^EDJTransformableMapBlock)(id object, id container);

@interface NSArray (EDJTransformable)

- (NSMutableArray *)containerMap:(EDJTransformableBlock)usingBlock;
- (NSMutableArray *)map:(EDJTransformableMapBlock)usingBlock;
@end
