//
//  EDJListHeaderFooterObject.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EDJListHeaderFooterObject : NSObject
@property (nonatomic, strong) id content;
- (CGFloat)height;
- (Class)viewClass;

@end
