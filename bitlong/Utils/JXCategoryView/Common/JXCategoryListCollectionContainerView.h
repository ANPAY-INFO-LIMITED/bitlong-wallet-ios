//
//  JXCategoryListCollectionContainerView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.

//

#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
@class JXCategoryListCollectionContainerView;

@protocol JXCategoryListCollectionContentViewDelegate <NSObject>

@optional
- (UIView *)listView;

- (void)listDidAppear;

- (void)listDidDisappear;

@end

@protocol JXCategoryListCollectionContainerViewDataSource <NSObject>
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListCollectionContainerView *)listContainerView;

- (id<JXCategoryListCollectionContentViewDelegate>)listContainerView:(JXCategoryListCollectionContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
- (Class)collectionViewClassInListContainerView:(JXCategoryListCollectionContainerView *)listContainerView;

- (BOOL)listContainerView:(JXCategoryListCollectionContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;
@end


@protocol JXCategoryListCollectionScrollViewDelegate <NSObject>

@optional
-(void)JXCategoryListCollectionScrollViewScrollViewDidScroll:(UIScrollView *)scrollView;
-(void)JXCategoryListCollectionScrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
-(void)JXCategoryListCollectionScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface JXCategoryListCollectionContainerView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListCollectionContentViewDelegate>> *validListDict;   
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@property (nonatomic, weak) id<JXCategoryListCollectionScrollViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithDataSource:(id<JXCategoryListCollectionContainerViewDataSource>)dataSource NS_DESIGNATED_INITIALIZER;
- (void)reloadData;

@end

