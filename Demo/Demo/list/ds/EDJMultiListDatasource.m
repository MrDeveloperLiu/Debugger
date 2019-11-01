//
//  EDJMultiListDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJMultiListDatasource.h"

@implementation EDJMultiListDatasource

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

- (void)setSections:(NSMutableArray *)sections{
    if (_sections != sections) {
        _sections = sections;
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.cells.count;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    if (objects.footer) {
        Class class = objects.footer.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        view.model = objects.footer;
        return view;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    if (objects.header) {
        Class class = objects.header.viewClass;
        NSParameterAssert(class);
        NSString *identifier = NSStringFromClass(class);
        EDJListHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            view = [[class alloc] initWithReuseIdentifier:identifier];
        }
        view.model = objects.header;
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self itemAtIndexPath:indexPath];
    return model.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.footer.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    EDJListObjects *objects = [self sectionAtIndex:section];
    return objects.header.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (EDJListObjects *)sectionAtIndexPath:(NSIndexPath *)indexPath{
    return [self sectionAtIndex:indexPath.section];
}

- (EDJListObjects *)sectionAtIndex:(NSUInteger)index{
    EDJListObjects *objects = [_sections objectAtIndex:index];
    return objects;
}

- (EDJListObject *)itemAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObjects *objects = [_sections objectAtIndex:indexPath.section];
    EDJListObject *model = [objects.cells objectAtIndex:indexPath.row];
    return model;
}
@end
