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

#import "TextFiledViewController.h"

@interface ViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Main";
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    /*
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSDictionary *paramters = @{@"1" : @"中文", @"2" : @"English"};
    [NETComp requestWithBaseUrl:url method:kHTTPMethodPOST paramters:paramters successBlock:^(id<NetTask> task, NSURLResponse *response, id data) {
    } failedBlock:^(id<NetTask> task, NSURLResponse *response, NSError *error) {
    }];
     */
    NSMutableArray *datas = @[@[@"1-1", @"1-2"].mutableCopy,
                              @[@"2-1"].mutableCopy,
                              @[@"3-1", @"3-2", @"3-3"].mutableCopy
                              ].mutableCopy;
    self.ds.datas = datas;
}

- (EDJOrderView *)collectionView{
    if (!_collectionView) {
        _collectionView = [EDJOrderView new];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _ds = [[EDJOrderDatasource alloc] initWithOrderView:_collectionView delegate:self];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self.ds itemAtIndexPath:indexPath];
    if ([item isEqualToString:@"2-1"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TextFiledViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TextFiledViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.ds deleteItemAtIndexPath:indexPath];
    }
}
@end
