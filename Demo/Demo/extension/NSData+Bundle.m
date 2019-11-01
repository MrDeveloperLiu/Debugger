//
//  NSData+Bundle.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSData+Bundle.h"
#import "NSBundle+File.h"

@implementation NSData (Bundle)

+ (NSData *)dataInBundle:(NSString *)bundle name:(NSString *)name{
    NSString *fp = [NSBundle fileInBundle:bundle name:name];
    NSData *d = [NSData dataWithContentsOfFile:fp];
    return d;
}

@end
