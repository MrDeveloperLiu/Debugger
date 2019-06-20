//
//  ViewController.m
//  Demo
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import "ViewController.h"
#import "TextFiledViewController.h"
#import "DelegateViewController.h"
#import "DifferentImplViewController.h"

@interface ViewController () <UICollectionViewDelegate, DelegateViewControllerProtocol>
{
    __weak UIView *_tobeNeedHiddenView;
}
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"检测内存：%@", [DeDebugRefCount ref]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"屏幕 %@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    self.title = @"Main";
    
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;


    NSMutableArray *datas = @[@[@"1-1", @"1-2"].mutableCopy,
                              @[@"frp"].mutableCopy,
                              @[@"delegate", @"color", @"hidden"].mutableCopy
                              ].mutableCopy;
    self.ds.datas = datas;
    
    UIView *v = [UIView new]; v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    v.de_width(60).de_height(60).de_centerX(self.view.centerX).de_top(200 + kNavH);
    _tobeNeedHiddenView = v;
}

- (void)delegateViewController:(DelegateViewController *)vc hatesThatBlock:(BOOL)youNeedHidden{
    _tobeNeedHiddenView.hidden = youNeedHidden;
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
    }else if ([item isEqualToString:@"delegate"]){
        DelegateViewController *vc = [DelegateViewController new];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([item isEqualToString:@"color"]){
        id<DifferentImplProtocol> impl = [DifferentColorImpl new];
        DifferentImplViewController *vc = [[DifferentImplViewController alloc] initWithDifferentImpl:impl];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([item isEqualToString:@"hidden"]){
        id<DifferentImplProtocol> impl = [DifferentHiddenImpl new];
        DifferentImplViewController *vc = [[DifferentImplViewController alloc] initWithDifferentImpl:impl];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.ds deleteItemAtIndexPath:indexPath];
    }
}
@end
