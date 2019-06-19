//
//  DeSubject.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Debugger/Debugger.h>

@protocol DeSubscribler;

@interface DeSubject : DeSignal <DeSubscribler>
+ (instancetype)subject;
@end


