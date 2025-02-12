//
//  JXCategoryView.h

//
//  Created by jiaxin on 2018/3/15.

//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCell.h"
#import "JXCategoryBaseCellModel.h"
#import "JXCategoryCollectionView.h"
#import "JXCategoryViewDefines.h"

@class JXCategoryBaseView;

@protocol JXCategoryViewDelegate <NSObject>

@optional


- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index;

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;

@end

@interface JXCategoryBaseView : UIView

@property (nonatomic, strong, readonly) JXCategoryCollectionView *collectionView;

@property (nonatomic, strong) NSArray <JXCategoryBaseCellModel *> *dataSource;

@property (nonatomic, weak) id<JXCategoryViewDelegate> delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;    

@property (nonatomic, assign) NSInteger defaultSelectedIndex;   

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign, getter=isContentScrollViewClickTransitionAnimationEnabled) BOOL contentScrollViewClickTransitionAnimationEnabled;    

@property (nonatomic, assign) CGFloat contentEdgeInsetLeft;     

@property (nonatomic, assign) CGFloat contentEdgeInsetRight;    

@property (nonatomic, assign) CGFloat cellWidth;    

@property (nonatomic, assign) CGFloat cellWidthIncrement;    

@property (nonatomic, assign) CGFloat cellSpacing;    

@property (nonatomic, assign, getter=isAverageCellSpacingEnabled) BOOL averageCellSpacingEnabled;     


@property (nonatomic, assign, getter=isCellWidthZoomEnabled) BOOL cellWidthZoomEnabled;     

@property (nonatomic, assign, getter=isCellWidthZoomScrollGradientEnabled) BOOL cellWidthZoomScrollGradientEnabled;     

@property (nonatomic, assign) CGFloat cellWidthZoomScale;    

@property (nonatomic, assign, getter=isSelectedAnimationEnabled) BOOL selectedAnimationEnabled;    

@property (nonatomic, assign) NSTimeInterval selectedAnimationDuration;     

- (void)selectItemAtIndex:(NSInteger)index;

- (void)reloadData;

- (void)reloadCellAtIndex:(NSInteger)index;

@end

@interface JXCategoryBaseView (UISubclassingBaseHooks)


- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;


- (CGRect)getTargetSelectedCellFrame:(NSInteger)targetIndex selectedType:(JXCategoryCellSelectedType)selectedType;

- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)refreshDataSource;

- (void)refreshState NS_REQUIRES_SUPER;

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset NS_REQUIRES_SUPER;

- (BOOL)selectCellAtIndex:(NSInteger)index selectedType:(JXCategoryCellSelectedType)selectedType NS_REQUIRES_SUPER;

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index;

- (Class)preferredCellClass;

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index NS_REQUIRES_SUPER;

@end
