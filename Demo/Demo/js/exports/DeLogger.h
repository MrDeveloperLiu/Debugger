//
//  DeLogger.h
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

@protocol DeLogger <JSExport>
@property (nonatomic, copy, readonly) NSString *name;

JSExportAs(log, - (void)log:(id)sth);
JSExportAs(initWithName, - (instancetype)initWithName:(NSString *)name);

@end

@interface DeLogger : NSObject <DeLogger>

@end

