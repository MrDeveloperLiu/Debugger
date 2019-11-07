//
//  EDJListViewCell.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJListObjects.h"

@interface EDJListViewCell : UITableViewCell
@property (nonatomic, strong) EDJListObject *model;

- (void)refreshContent:(id)content;
@end