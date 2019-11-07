//
//  EDJListHeaderFooterView.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJListObjects.h"

@interface EDJListHeaderFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) EDJListHeaderFooterObject *model;
- (void)refreshContent:(id)content;
@end
