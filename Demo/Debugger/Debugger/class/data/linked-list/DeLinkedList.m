//
//  DeLinkedList.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/28.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeLinkedList.h"

@implementation DeLinkedList

- (instancetype)init{
    self = [super init];
    _count = 0;
    _head = nil;
    return self;
}

- (void)_insertObjectAtHead:(id)object{
    DeLinkedNode *headNode = _head;
    DeLinkedNode *node = [DeLinkedNode nodeWithValue:object];
    node.next = headNode;
    _head = node;
}

- (void)_insertObjectAtTrail:(id)object{
    DeLinkedNode *lastNode = _head;
    while (lastNode.next) {
        lastNode = lastNode.next;
    }
    DeLinkedNode *node = [DeLinkedNode nodeWithValue:object];
    lastNode.next = node;
    _trail = node;
}

- (void)_insertObjectAtMiddle:(id)object index:(NSUInteger)index{
    DeLinkedNode *previous = nil;
    DeLinkedNode *current = _head;

    DeLinkedNode *node = [DeLinkedNode nodeWithValue:object];
    
    NSUInteger idx = 1;
    while (current.next) {
        
        previous = current;
        current = current.next;
        
        if (idx == index) {
            
            node.next = current;
            previous.next = node;
            
            break;
        }
        
        idx ++;
    }
}


- (void)appendObject:(id)object{
    NSParameterAssert(object);
    if (!_head) {
        [self _insertObjectAtHead:object];
    }else{
        [self _insertObjectAtTrail:object];
    }
    _count += 1;
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index{
    NSParameterAssert(object);
    if (index >= 0 && index <= _count) {
        if (index == 0) {
            [self _insertObjectAtHead:object];
        }else if (index == _count){
            [self _insertObjectAtTrail:object];
        }else{
            [self _insertObjectAtMiddle:object index:index];
        }
    }else{
        NSAssert(NO, @"Error index:%zd beyond count:%zd", index, _count);
    }
    _count += 1;
}

- (id)removeObjectAtIndex:(NSUInteger)index{
    if (index >= 0 && index <= _count) {
        if (index == 0) {
            return [self removeHead];
        }else if (index == _count){
            return [self removeLast];
        }else{
            return [self removeMiddle:index];
        }
    }else{
        NSAssert(NO, @"Error index:%zd beyond count:%zd", index, _count);
    }
    return nil;
}

- (id)removeMiddle:(NSUInteger)index{
    DeLinkedNode *previous = nil;
    DeLinkedNode *current = _head;

    NSUInteger idx = 1;
    while (current.next) {
        
        previous = current;
        current = current.next;
        
        if (idx == index) {
            previous.next = current.next;
            _count -= 1;
            break;
        }
        idx ++;
    }
    return current;
}

- (id)removeHead{
    if (_head) {
        DeLinkedNode *head = _head;
        _head = _head.next;
        _count -= 1;
        return head;
    }
    return nil;
}

- (id)removeLast{
    if (_head) {
        DeLinkedNode *lastNode = _head;
        while (lastNode.next && lastNode.next.next) {
            lastNode = lastNode.next;
        }
        if (!lastNode.next) { 
            _head = nil;
        }else{
            lastNode.next = nil;
        }
        _count -= 1;
        return lastNode;
    }
    return nil;
}

- (id)objectAtIndex:(NSUInteger)index{
    if (index >= 0 && index <= _count) {
        if (index == 0) {
            return _head;
        }else if (index == _count){
            return _trail;
        }
        return [self _objectAtMiddle:index];
    }
    NSAssert(NO, @"Error index:%zd beyond count:%zd", index, _count);
    return nil;
}
- (id)_objectAtMiddle:(NSUInteger)index{
    DeLinkedNode *current = _head;
    NSUInteger idx = 1;
    while (current.next) {
        current = current.next;
        if (idx == index) {
            break;
        }
        idx ++;
    }
    return current;
}
@end
