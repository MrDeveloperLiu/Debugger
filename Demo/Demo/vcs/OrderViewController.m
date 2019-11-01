//
//  OrderViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "OrderViewController.h"
#import "EDJOrderContentView.h"
#import "EDJOrderListView.h"
#import "NSData+Bundle.h"

@interface OrderViewController () <UITableViewDelegate>
@property (nonatomic, strong) EDJOrderListView *orderView;
@property (nonatomic, strong) EDJSingleListDatasource *ds;

@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) UIButton *button;
@end

@implementation OrderViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EDJListObject *model = [self.ds itemAtIndexPath:indexPath];
    return model.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat top = self.orderView.contentView.top - self.navigationBar.height;
    if (offsetY > -top) {
        if (self.navigationBar.top != -self.navigationBar.height) {
            self.navigationBar.top = -self.navigationBar.height;
        }
    }else{
        if (self.navigationBar.top != 0) {
            self.navigationBar.top = 0;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    self.orderView = [[EDJOrderListView alloc] initWithFrame:self.view.bounds];
    self.ds = [[EDJSingleListDatasource alloc] initWithTableView:self.orderView delegate:self];
    [self.view addSubview:self.orderView];
    [self.view addSubview:self.button];
    [self.view addSubview:self.navigationBar];
    
    [self loadData];
}

- (void)loadData{
    NSData *adData = [NSData dataInBundle:@"res" name:@"ad.json"];
    id adJson = [NSJSONSerialization JSONObjectWithData:adData options:0 error:nil];
    self.ds.datas = [adJson containerMap:^id(id obj){
        return [obj transform_toListItem];
    }];
        
    NSData *spData = [NSData dataInBundle:@"res" name:@"main.json"];
    id spJson = [NSJSONSerialization JSONObjectWithData:spData options:0 error:nil];
    self.orderView.contentView.selectView.ds.datas = [spJson containerMap:^id(id obj){
        return [obj transform_toOrderItem];
    }];
    
        
    NSData *vpData = [NSData dataInBundle:@"res" name:@"view.json"];
    id vpJson = [NSJSONSerialization JSONObjectWithData:vpData options:0 error:nil];
    self.orderView.contentView.collectionView.ds.datas = [vpJson containerMap:^id(id obj){
        return [obj transform_toOrderItem];
    }];

}

- (UIView *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [UIView new];
        CGSize s = self.view.bounds.size;
        _navigationBar.frame = CGRectMake(0, 0, s.width, 100);
        _navigationBar.backgroundColor = [UIColor redColor];
    }
    return _navigationBar;
}

- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setBackgroundImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _button.frame = CGRectMake(15, 20, 30, 30);
    }
    return _button;
}

- (void)buttonAction:(id)sender{
    [self.orderView setContentOffset:CGPointMake(0, -self.orderView.height+self.orderView.bottomOffset) animated:YES];
}
@end



