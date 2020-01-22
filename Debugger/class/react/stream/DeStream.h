//
//  DeStream.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeStream <NSObject>
- (instancetype)map:(id (^)(id x))transform;
- (instancetype)filter:(BOOL (^)(id x))transform;
- (instancetype)bind:(id (^)(id x))transform;
@end

@interface DeStream : NSObject

@end

@interface DeStream (DeStream) <DeStream>

@end

