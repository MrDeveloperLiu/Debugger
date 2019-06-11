//
//  DeFileLogger.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DeFileLogLevelINFO      "[INFO]"
#define DeFileLogLevelError     "[ERROR]"
#define DeFileLogLevelNET       "[NET]"
#define DeFileLogLevelTRACK     "[TRACK]"

#define DeLogInfo(format, ...) [[DeFileLogger logger] log:de_fmt_string(format, ##__VA_ARGS__)];
#define DeLogError(format, ...) [[DeFileLogger logger] logWithLevel:@DeFileLogLevelError text:de_fmt_string(format, ##__VA_ARGS__)];
#define DeLogTrack [[DeFileLogger logger] logWithLevel:@DeFileLogLevelTRACK text:de_fmt_string(@"%s", __FUNCTION__)];


@interface DeFileLogger : NSObject

+ (dispatch_queue_t)loggerQueue;
+ (DeFileLogger *)logger;

@property (nonatomic, copy, readonly) NSString *fp;
@property (nonatomic, strong, readonly) NSFileHandle *handler;
@property (nonatomic, strong, readonly) NSDateFormatter *format;

- (instancetype)initWithFilePath:(NSString *)filePath;
- (void)logWithLevel:(NSString *)level text:(NSString *)text;
- (void)log:(NSString *)text;
@end

FOUNDATION_EXPORT NSString *de_fmt_string(NSString *format, ...);

