//
//  DeFileDirectory.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DeFileDirectory : NSObject

+ (NSString *)documentPath;
+ (NSString *)loggerPath;

+ (BOOL)createDirectoryAtPath:(NSString *)path;
+ (BOOL)createFileAtPath:(NSString *)path;


+ (NSString *)createLogFile:(NSString *)fileName;
@end

