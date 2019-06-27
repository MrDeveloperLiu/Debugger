//
//  ViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import "ViewController.h"
#import "TextFiledViewController.h"
#import "UIApplication+NetComponents.h"

@interface ViewController () <UICollectionViewDelegate>
{
    __weak UIView *_tobeNeedHiddenView;
}
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Main";
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;


    NSMutableArray *datas = @[@[@"1-1", @"1-2"].mutableCopy,
                              @[@"frp"].mutableCopy,
                              @[@"delegate", @"color", @"hidden"].mutableCopy
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
    if ([item isEqualToString:@"frp"]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TextFiledViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TextFiledViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.ds deleteItemAtIndexPath:indexPath];
    }
}
@end
