//
//  EDJOrderItem.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EDJOrderItemLayout : NSObject
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat margin;
@end


@interface EDJOrderItem : NSObject <NSCopying, NSMutableCopying>
@property (nonatomic, strong) id content;
@property (nonatomic, strong) EDJOrderItemLayout *layout;
@end
