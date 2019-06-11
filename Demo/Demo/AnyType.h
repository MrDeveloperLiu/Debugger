//
//  AnyType.h
//  Demo
//
//  Created by 刘杨 on 2019/4/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnyTypeEntry <ObjectType> : NSObject
@property (nonatomic, strong) ObjectType internal;
- (void)exchangedInternal:(ObjectType)internal;
@end
