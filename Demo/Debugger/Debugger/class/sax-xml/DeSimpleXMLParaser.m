//
//  SimpleXMLParaser.m
//  Demo
//
//  Created by 刘杨 on 2019/5/8.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSimpleXMLParaser.h"


@interface DeSimpleXMLParaser () <NSXMLParserDelegate>
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) DeSimpleXMLNode *root;
@end

@implementation DeSimpleXMLParaser

- (instancetype)initWithXMLString:(NSString *)string{
    return [self initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

- (instancetype)initWithData:(NSData *)data{
    self = [super init];
    _parser = [[NSXMLParser alloc] initWithData:data];
    _parser.delegate = self;
    return self;
    
}

- (instancetype)initWithUrl:(NSURL *)url{
    self = [super init];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
    return self;
}

- (void)begin{
    [_parser parse];
}

- (void)fininshed{
    if (_completionBlock) {
        _completionBlock(self, _error);
        _completionBlock = nil;
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
//    NSLog(@"开始解析");
}
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [self fininshed];
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
//    NSLog(@"解析出错:%@", parseError);
    _error = parseError;
    [self fininshed];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    DeSimpleXMLNode *node = [[DeSimpleXMLNode alloc] initWithElement:elementName attri:attributeDict];
    node.namespaceURI = namespaceURI;
    node.qName = qName;
    node.open = YES;
    //root节点
    if (!self.root) {
        self.root = node;
        return;
    }
    //当前节点
    DeSimpleXMLNode *currentNode = [self.root currentNode];
    //子集最后元素打开
    if ([currentNode open]) {
        node.father = currentNode;
        [currentNode insertNode:node];
    //root子节点
    }else{
        node.father = self.root;
        [self.root insertNode:node];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    //root节点
    if ([self.root.element isEqualToString:elementName]) {
        self.root.open = NO;
        return;
    }
    //关闭当前子节点
    DeSimpleXMLNode *node = [self.root currentNode];
    if ([node.element isEqualToString:elementName]) {
        node.open = NO;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    DeSimpleXMLNode *node = [self.root currentNode];
    //当前节点
    if (node) {
        node.content = string;
        return;
    }
    //root节点
    self.root.content = string;
}
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    DeSimpleXMLNode *node = [self.root currentNode];
    //当前节点
    if (node) {
        node.data = CDATABlock;
        return;
    }
    //root节点
    self.root.data = CDATABlock;
}
@end
