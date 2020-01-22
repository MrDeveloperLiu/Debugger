//
//  DeFileDirectory.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeFileDirectory.h"

@implementation DeFileDirectory

+ (NSString *)documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
}

+ (NSString *)loggerPath{
    return [[self documentPath] stringByAppendingPathComponent:@"DeLog"];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
    }
    return YES;
}

+ (BOOL)createFileAtPath:(NSString *)path{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [[NSFileManager defaultManager] createFileAtPath:path
                                                       contents:nil
                                                     attributes:nil];
    }
    return YES;
}

+ (NSString *)createLogFile:(NSString *)fileName{
    NSString *logPath = [self loggerPath];
    [self createDirectoryAtPath:logPath];
    NSString *filePath = [logPath stringByAppendingPathComponent:fileName];
    [self createFileAtPath:filePath];
    return filePath;
}

@end
