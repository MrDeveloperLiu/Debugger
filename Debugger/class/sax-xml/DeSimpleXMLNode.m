//
//  SimpleXMLNode.m
//  Demo
//
//  Created by 刘杨 on 2019/5/9.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSimpleXMLNode.h"


@implementation DeSimpleXMLNode
//根节点元素
- (NSDictionary *)rootObject{
    NSMutableDictionary *retVal = @{}.mutableCopy;
    retVal[self.element] = [self jsonObject];
    return retVal;
}
//子节点转化为json
- (id)jsonObject{
    //是元素
    if (_children.count <= 0) {
        return self.content;
    }
    //是字典
    if (_childrenMap.count == _children.count) {
        return [self dictObject];
    }
    //数组
    return [self arrayObject];
}
//转化为key:array
- (NSDictionary *)arrayObject{
    NSMutableDictionary *subDict = @{}.mutableCopy;
    NSMutableArray *subArray = @[].mutableCopy;
    NSString *subKey = self.childrenMap.allKeys.lastObject;
    subDict[subKey] = subArray;
    [_children enumerateObjectsUsingBlock:^(DeSimpleXMLNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [subArray addObject:[obj jsonObject]];
    }];
    return subDict;
}
//转化为key:value
- (NSDictionary *)dictObject{
    NSMutableDictionary *retVal = @{}.mutableCopy;
    //只有一个键值对
    if (_children.count <= 0) {
        retVal[self.element] = self.content;
        return retVal;
    }
    //有多个键值对
    [_children enumerateObjectsUsingBlock:^(DeSimpleXMLNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        retVal[obj.element] = obj.content;
    }];
    return retVal;
}

- (NSMutableArray<DeSimpleXMLNode *> *)children{
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

- (NSMutableDictionary<NSString *,NSMutableArray *> *)childrenMap{
    if (!_childrenMap) {
        _childrenMap = [NSMutableDictionary dictionary];
    }
    return _childrenMap;
}

//当前子节点的自己节点最后一元素
- (DeSimpleXMLNode *)currentNode{
    DeSimpleXMLNode *lastNode = _children.lastObject;
    if ([lastNode subNodes]) {//递归找到最后一个打开的节点
        DeSimpleXMLNode *lastSubNode = [lastNode currentNode];
        if ([lastSubNode open]) {
            return lastSubNode;
        }
    }
    return lastNode;
}

- (BOOL)subNodes{
    return _children.count > 0;
}

- (void)insertNode:(DeSimpleXMLNode *)node{
    if (![self.children containsObject:node]) {
        [self.children addObject:node];
        //插入map
        NSMutableArray *nodes = [self nodes:node];
        [nodes addObject:node];
    }
}

- (NSMutableArray *)nodes:(DeSimpleXMLNode *)node{
    NSMutableArray *nodes = self.childrenMap[node.element];
    if (!nodes) {
        nodes = [NSMutableArray array];
        self.childrenMap[node.element] = nodes;
    }
    return nodes;
}

- (instancetype)initWithElement:(NSString *)element attri:(NSDictionary *)attri{
    self = [super init];
    _element = element;
    _attributes = attri;
    _open = YES;
    return self;
}

- (instancetype)init{
    return [self initWithElement:nil attri:nil];
}
@end
