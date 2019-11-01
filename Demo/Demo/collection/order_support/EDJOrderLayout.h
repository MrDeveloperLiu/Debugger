//
//  EDJOrderLayout.h
//  Demo
//
//  Created by 刘杨 on 2019/10/21.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJLayout.h"


@class EDJOrderLayout;
@protocol EDJOrderLayoutDelegate <NSObject>
- (void)orderLayout:(EDJOrderLayout *)layout willBeginLayout:(CGSize)size;
- (void)orderLayout:(EDJOrderLayout *)layout didFinishLayout:(CGSize)size;
@end


@interface EDJOrderLayout : EDJLayout
@property (nonatomic, weak) id<EDJOrderLayoutDelegate> sizeDelegate;
@end


@interface EDJOrderLayoutManager : EDJLayoutManager
@end
