//
//  ViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import "ViewController.h"
#import "EDJOrderView.h"
#import "UIApplication+NetComponents.h"

@interface ViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    
    /*
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSDictionary *paramters = @{@"1" : @"中文", @"2" : @"English"};

    [NETComp requestWithBaseUrl:url method:kHTTPMethodPOST paramters:paramters successBlock:^(id<NetTask> task, NSURLResponse *response, id data) {
        NSLog(@"%@", data);
    } failedBlock:^(id<NetTask> task, NSURLResponse *response, NSError *error) {
        if (task.isCanceled) {
            NSLog(@"canceled: %@", error);
        }else{
            NSLog(@"%@", [error description]);
        }
    }];
    */
    
    [[DeSignal createSignal:^DeDispose *(id<DeSubscribler> subscribler) {
        return [[DeScheduler mainthreadScheduler] scheduleAfter:2.0 block:^{
            NSMutableArray *datas = @[@[@"1-1", @"1-2"].mutableCopy,
                                      @[@"2-1"].mutableCopy,
                                      @[@"3-1", @"3-2", @"3-3"].mutableCopy
                                      ].mutableCopy;
            [subscribler sendNext:datas];
            
            [subscribler sendCompleted];
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"next:%@", x);
        self.ds.datas = x;
    } completed:^{
        NSLog(@"completed");
        [self.collectionView reloadData];
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
