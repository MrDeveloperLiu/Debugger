//
//  NSData+Bundle.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSData (Bundle)
+ (NSData *)dataInBundle:(NSString *)bundle name:(NSString *)name;
@end

