//
//  DelegateViewController.h
//  Demo
//
//  Created by 刘杨 on 2019/6/20.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DelegateViewController;
@protocol DelegateViewControllerProtocol <NSObject>
- (void)delegateViewController:(DelegateViewController *)vc hatesThatBlock:(BOOL)youNeedHidden;
@end

@interface DelegateViewController : UIViewController
@property (nonatomic, weak) id <DelegateViewControllerProtocol> delegate;
@end


