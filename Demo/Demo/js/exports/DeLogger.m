//
//  DeLogger.m
//  Demo
//
//  Created by 刘杨 on 2019/7/12.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeLogger.h"

@interface DeLogger ()
@property (nonatomic, copy) NSString *name;
@end

@implementation DeLogger

- (instancetype)init{
    self = [super init];
    _name = @"DeLogger";
    return self;
}

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    _name = name;
    return self;
}

- (void)log:(id)sth{
    if ([sth isKindOfClass:[NSString class]]) {
        NSLog(@"[%@]- [str]: %@", _name, sth);
    }else if ([sth isKindOfClass:[NSArray class]]){
        NSLog(@"[%@]- [arr]: %@", _name, sth);
    }else if ([sth isKindOfClass:[NSDictionary class]]){
        NSLog(@"[%@]- [dict]: %@", _name, sth);
    }else{
        NSLog(@"[%@]- [undefined]: %@", _name, sth);
    }
}

@end
