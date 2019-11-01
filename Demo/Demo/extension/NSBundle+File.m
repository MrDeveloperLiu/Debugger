//
//  NSBundle+File.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSBundle+File.h"

@implementation NSBundle (File)

+ (NSString *)fileInBundle:(NSString *)bundle name:(NSString *)name{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"];
    NSBundle *resBundle = [NSBundle bundleWithPath:bundlePath];
    if (!resBundle) {
        resBundle = [NSBundle mainBundle];
    }
    NSString *fp = [resBundle pathForResource:name ofType:nil];
    return fp;
}

@end
