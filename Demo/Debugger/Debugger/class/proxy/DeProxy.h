//
//  DeProxy.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DeProxy : NSProxy
@property (nonatomic, weak, readonly) id target;
+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;
@end


