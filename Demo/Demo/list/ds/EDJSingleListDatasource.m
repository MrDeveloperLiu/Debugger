//
//  EDJTableDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJSingleListDatasource.h"

@implementation EDJSingleListDatasource

- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<UITableViewDelegate>)delegate{
    self = [super init];
    _tableView = tableView;
    _tableView.dataSource = self;
    self.delegate = delegate;
    return self;
}

- (void)setDelegate:(id)delegate{
    _delegate = delegate;
    if (delegate) {
        _tableView.delegate = delegate;
    }else{
        _tableView.delegate = self;
    }
}

- (void)setDatas:(NSMutableArray *)datas{
    if (_datas != datas) {
        _datas = datas;
        [self.tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    Class class = model.viewClass;
    NSParameterAssert(class);
    NSString *identifier = NSStringFromClass(class);
    EDJListViewCell *cell = (EDJListViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return model.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [_datas objectAtIndex:indexPath.row];
    return model;
}
@end
