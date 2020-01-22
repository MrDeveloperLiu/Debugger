//
//  DeFileLogger.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeFileLogger.h"
#import "DeFileDirectory.h"

@implementation DeFileLogger

+ (dispatch_queue_t)loggerQueue{
    static dispatch_queue_t loggerQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loggerQueue = dispatch_queue_create("DeFileLogger", DISPATCH_QUEUE_SERIAL);
    });
    return loggerQueue;
}

+ (DeFileLogger *)logger{
    static DeFileLogger *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithFilePath:nil];
    });
    return _instance;
}

- (instancetype)initWithFilePath:(NSString *)filePath{
    self = [super init];
    _format = [[NSDateFormatter alloc] init];    
    if (!filePath) {
        _format.dateFormat = @"yyyyMMdd-HHmmss";
        NSString *fileName = [_format stringFromDate:[NSDate date]];
        filePath = [DeFileDirectory createLogFile:[fileName stringByAppendingPathExtension:@"log"]];
    }
    _format.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    _handler = [NSFileHandle fileHandleForWritingAtPath:filePath];
    _fp = filePath;
    return self;
}

- (void)logWithLevel:(NSString *)level text:(NSString *)text{
    if (![text isKindOfClass:[NSString class]]) {
        return;
    }
    NSString *logLevel = level;
    if (!logLevel) {
        logLevel = @"";
    }
    NSString *time = [_format stringFromDate:[NSDate date]];
    NSString *logString = [NSString stringWithFormat:@"%@ %@ %@\n", time, logLevel, text];
#if DEBUG
    printf("[DELOG]: %s", logString.UTF8String);
#endif
    __weak __typeof(self) ws = self;
    NSData *logData = [logString dataUsingEncoding:NSUTF8StringEncoding];
    dispatch_sync([DeFileLogger loggerQueue], ^{
        [ws.handler writeData:logData];
    });
}

- (void)log:(NSString *)text{
    [self logWithLevel:@DeFileLogLevelINFO text:text];
}
@end

NSString *de_fmt_string(NSString *format, ...){
    if (!format) {
        return nil;
    }
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    return string;
}
