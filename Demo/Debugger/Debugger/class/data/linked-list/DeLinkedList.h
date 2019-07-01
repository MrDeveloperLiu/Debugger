//
//  DeLinkedList.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/28.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeLinkedNode.h"


@interface DeLinkedList<ObjectType> : NSObject

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong, readonly) DeLinkedNode <ObjectType>* head;
@property (nonatomic, strong, readonly) DeLinkedNode <ObjectType>* trail;

- (void)appendObject:(ObjectType)object;
- (ObjectType)removeHead;
- (ObjectType)removeLast;

- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)index;
- (ObjectType)removeObjectAtIndex:(NSUInteger)index;

- (ObjectType)objectAtIndex:(NSUInteger)index;
@end

