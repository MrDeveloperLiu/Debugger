//
//  EDJListObject.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDJListObject : NSObject
@property (nonatomic, strong) id content;
- (CGFloat)rowHeight;
- (Class)viewClass;
@end
