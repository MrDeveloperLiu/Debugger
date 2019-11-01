//
//  NSBundle+File.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (File)
+ (NSString *)fileInBundle:(NSString *)bundle name:(NSString *)name;
@end
