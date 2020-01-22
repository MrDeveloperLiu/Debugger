//
//  SimpleXMLParaser.h
//  Demo
//
//  Created by 刘杨 on 2019/5/8.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSimpleXMLNode.h"

@class DeSimpleXMLParaser;
typedef void(^SimpleXMLParaserBlock) (DeSimpleXMLParaser *p, NSError *error);

@interface DeSimpleXMLParaser : NSObject
@property (nonatomic, strong, readonly) DeSimpleXMLNode *root;
@property (nonatomic, strong, readonly) NSError *error;

@property (nonatomic, copy) SimpleXMLParaserBlock completionBlock;

- (instancetype)initWithXMLString:(NSString *)string;
- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithUrl:(NSURL *)url;

- (void)begin;
@end



