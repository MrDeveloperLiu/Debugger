//
//  NSObject+EDJTransformable.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//


#import <Foundation/Foundation.h>

@class EDJOrderItem;
@class EDJListObject;


@protocol EDJTransformable <NSObject>

- (EDJOrderItem *)transform_toOrderItem;

- (EDJListObject *)transform_toListItem;

@end




@interface NSObject (EDJTransformable) <EDJTransformable>
@end

