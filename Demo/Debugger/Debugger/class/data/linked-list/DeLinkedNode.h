//
//  DeLinkedNode.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/28.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeLinkedNode<ObjectType> : NSObject
@property (nonatomic, strong, readonly) ObjectType value;

@property (nonatomic, strong) DeLinkedNode *next;

- (instancetype)initWithValue:(ObjectType)value;
+ (instancetype)nodeWithValue:(ObjectType)value;
@end

