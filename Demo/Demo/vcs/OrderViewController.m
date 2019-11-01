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

@interface OrderViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) EDJOrderListView *orderView;
@end

@implementation OrderViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"c_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"广告区域";
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    // Do any additional setup after loading the view.
    self.orderView = [[EDJOrderListView alloc] initWithFrame:self.view.bounds];
    self.orderView.dataSource = self;
    self.orderView.delegate = self;
    [self.view addSubview:self.orderView];
    
    
        
    NSData *spData = [NSData dataInBundle:@"res" name:@"main.json"];
    id spJson = [NSJSONSerialization JSONObjectWithData:spData options:0 error:nil];
    self.orderView.contentView.selectView.ds.datas = [spJson containerMap:^id(id obj){
        return [obj toItem];
    }];
    
        
    NSData *vpData = [NSData dataInBundle:@"res" name:@"view.json"];
    id vpJson = [NSJSONSerialization JSONObjectWithData:vpData options:0 error:nil];
    self.orderView.contentView.collectionView.ds.datas = [vpJson containerMap:^id(id obj){
        return [obj toItem];
    }];
        
}

@end



