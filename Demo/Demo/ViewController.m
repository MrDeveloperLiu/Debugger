//
//  ViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import "ViewController.h"
#import "AnyType.h"
#import "EDJOrderView.h"

#import <Debugger/Debugger.h>

@interface ViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;

@property (nonatomic, strong) DeHTTPManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    self.ds.datas = @[@[@"1", @"2", @"3"].mutableCopy ].mutableCopy;
    
    
    DeReachable *reachable = [DeReachable reachable];
    [reachable start];
    
    self.manager = [DeHTTPManager manager];
    [self.manager setReachableBlock:^BOOL{
        return ![reachable notReachable];
    }];
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSDictionary *paramters = @{@"1" : @"中文", @"2" : @"English"};
    [self.manager requestWithBaseUrl:url method:kHTTPMethodPOST paramters:paramters successBlock:^(DeHTTPDataTask *task, NSURLResponse *response, id data) {
        NSLog(@"%@", data);
    } failedBlock:^(DeHTTPDataTask *task, NSURLResponse *response, NSError *error) {
        if (task.isCanceled) {
            NSLog(@"canceled: %@", error);
        }else{
            NSLog(@"%@", [error description]);
        }
    }];
}

- (EDJOrderView *)collectionView{
    if (!_collectionView) {
        _collectionView = [EDJOrderView new];
        _ds = [[EDJOrderDatasource alloc] initWithOrderView:_collectionView delegate:self];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.ds deleteItemAtIndexPath:indexPath];
}
@end
