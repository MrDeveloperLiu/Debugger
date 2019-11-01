//
//  EDJTableDatasource.h
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDJListViewCell.h"
#import "EDJListHeaderFooterView.h"

@interface EDJSingleListDatasource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id <UITableViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *datas;

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<UITableViewDelegate>)delegate;
- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath;
@end


