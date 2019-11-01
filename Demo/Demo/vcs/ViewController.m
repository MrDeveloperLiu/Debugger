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
#import "OrderViewController.h"

#import "DeJavaScriptCore.h"
#import "EDJToastTitleView.h"
#import "DeAppWindow.h"

@interface ViewController () <UICollectionViewDelegate>
@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@property (nonatomic, strong) DeJavaScriptCore *jvm;

@property (nonatomic, strong) DeAppWindow *app;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Main";
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.frame = self.view.bounds;


    NSMutableArray *datas = @[@[@"1-1", @"1-2"],
                              @[@"order"],
                              @[@"js"]
                              ].mutableCopy;
    self.ds.datas = datas;
    
    
}

- (void)toastTest{
    EDJToastTitleView *t = [EDJToastTitleView new];
    t.color = [UIColor greenColor];
    t.top = 100;
    t.leading = 50;
    t.contentRadius = 3;
    t.trangleMode = EDJToastTipsViewTrangleModeTop;
    [t setTitle:@"Toast"];
    [t showInView:self.view];
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
    if ([item isEqualToString:@"order"]) {
        OrderViewController *vc = [[OrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([item isEqualToString:@"js"]) {
        
        _jvm = [DeJavaScriptCore new];
        
        DeLogger *log = [[DeLogger alloc] initWithName:@"Console"];
        [_jvm.jsContext registerInstance:@"console" instance:log];        
        [_jvm.jsContext loadJsFile:@"JSApplication.js" inBundle:nil];
        
                
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor redColor];
        DeAppWindow *app = [[DeAppWindow alloc] initWithRootViewController:vc];
        app.jvm = _jvm;
        [app show];
        _app = app;
        
    }
}
@end
