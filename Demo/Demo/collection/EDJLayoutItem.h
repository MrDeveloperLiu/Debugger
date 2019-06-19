//
//  EDJLayoutItem.h
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDJLayoutItem : UICollectionViewLayoutAttributes
+ (instancetype)itemWithIndexPath:(NSIndexPath *)indexPath frame:(CGRect)frame;
@end


