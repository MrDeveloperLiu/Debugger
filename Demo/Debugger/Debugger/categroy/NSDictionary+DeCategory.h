//
//  NSDictionary+DeCategory.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSDictionary (DeCategory)
- (BOOL)_deSafetyKey:(id)key;
- (BOOL)_deSafetyValue:(id)value;

- (id)deObjectForKey:(id)key;
@end

@interface NSMutableDictionary (DeCategory)
- (void)deSetObject:(id)object forKey:(id<NSCopying>)key;
@end


