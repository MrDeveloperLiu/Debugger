//
//  EDJLayout.h
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//


#import "EDJLayoutItems.h"

@class EDJLayoutManager, EDJLayout;

@protocol EDJLayoutManagerDelegate <NSObject>
@required
- (void)layoutManagerLayoutDidBegan:(EDJLayoutManager *)mgr;
- (void)layoutManagerLayoutDidFinshed:(EDJLayoutManager *)mgr;

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemWidth:(NSIndexPath *)indexPath;
- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemHeight:(NSIndexPath *)indexPath;
- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemMargin:(NSIndexPath *)indexPath;

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemXOffset:(NSInteger)section;
- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemYOffset:(NSInteger)section;
@end

typedef NS_ENUM(NSUInteger, EDJLayoutManagerDirection) {
    EDJLayoutManagerDirectionVertical,
    EDJLayoutManagerDirectionHorizontal,
};

@interface EDJLayoutManager : NSObject
@property (nonatomic, weak, readonly) EDJLayout *layout;

@property (nonatomic, strong, readonly) NSMutableArray *attributes;
@property (nonatomic, strong, readonly) NSMutableArray *items;

@property (nonatomic, assign, readonly) CGFloat estimateLineHeight;
@property (nonatomic, assign, readonly) CGFloat estimateItemHeight;

@property (nonatomic, assign) EDJLayoutManagerDirection direction;

- (instancetype)initWithLayout:(EDJLayout *)layout;
- (void)prepareLayout;

- (EDJLayoutItems *)layoutSection:(NSInteger)section counts:(NSInteger)counts;
- (void)layoutItemWithItems:(EDJLayoutItems *)items previous:(EDJLayoutItems *)previous;
@end



@protocol EDJLayoutDelegate <NSObject>
@optional
- (CGFloat)layoutCalculateWillBegin:(EDJLayout *)layout;
- (CGFloat)layoutCalculateDidFinished:(EDJLayout *)layout;

- (CGFloat)layout:(EDJLayout *)layout itemHorizontalOffset:(NSInteger)section;
- (CGFloat)layout:(EDJLayout *)layout itemVerticalOffset:(NSInteger)section;
- (CGFloat)layout:(EDJLayout *)layout itemHeight:(NSIndexPath *)indexPath;
- (CGFloat)layout:(EDJLayout *)layout itemWidth:(NSIndexPath *)indexPath;
- (CGFloat)layout:(EDJLayout *)layout itemMargin:(NSIndexPath *)indexPath;
@end


@interface EDJLayout : UICollectionViewLayout <EDJLayoutManagerDelegate>
{
@protected
    EDJLayoutManager *_layoutManager;
}
@property (nonatomic, strong, readonly) EDJLayoutManager *layoutManager;
@property (nonatomic, assign, readonly) CGSize viewSize;

@property (nonatomic, weak) id<EDJLayoutDelegate> delegate;

@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat height;

- (void)beginLayout;
- (void)endLayout;
@end
