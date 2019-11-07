//
//  EDJOrderView.h
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTouchView.h"
#import "EDJOrderContainer.h"

@interface EDJOrderContentView : EDJTableTouchView
@property (nonatomic, strong, readonly) EDJOrderContainer *insetView;
@property (nonatomic, assign) CGFloat bottomOffset;
@end


