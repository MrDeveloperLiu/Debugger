//
//  SimpleXMLNode.h
//  Demo
//
//  Created by 刘杨 on 2019/5/9.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeSimpleXMLNode : NSObject
//父节点
@property (nonatomic, weak) DeSimpleXMLNode *father;
//子节点
@property (nonatomic, strong) NSMutableArray <DeSimpleXMLNode *> *children;
//子节点映射关系
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray *> *childrenMap;
//标签名称
@property (nonatomic, copy) NSString *element;
//标签属性
@property (nonatomic, strong) NSDictionary *attributes;
//标签内容
@property (nonatomic, copy) NSString *content;
//节点打开
@property (nonatomic, assign) BOOL open;
//data
@property (nonatomic, copy) NSData *data;
//节点属性
@property (nonatomic, copy) NSString *namespaceURI;
//节点属性
@property (nonatomic, copy) NSString *qName;

- (instancetype)initWithElement:(NSString *)element attri:(NSDictionary *)attri;
//当前子节点的自己节点最后一元素
- (DeSimpleXMLNode *)currentNode;
//插入子节点
- (void)insertNode:(DeSimpleXMLNode *)node;
- (BOOL)subNodes;
- (NSDictionary *)rootObject;
@end
