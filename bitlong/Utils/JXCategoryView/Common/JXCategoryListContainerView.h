//
//  JXCategoryListScrollView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.

//

#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
@class JXCategoryListContainerView;

@protocol JXCategoryListContentViewDelegate <NSObject>

- (UIView *)listView;

@optional

- (void)listDidAppear;

- (void)listDidDisappear;

- (UIScrollView *)listScrollView;

@end

@protocol JXCategoryListContainerViewDelegate <NSObject>
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView;

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
- (UIScrollView *)scrollViewInlistContainerView:(JXCategoryListContainerView *)listContainerView;

- (BOOL)listContainerView:(JXCategoryListContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;

@end


@interface JXCategoryListContainerView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;   
@property (nonatomic, assign) CGFloat didAppearPercent;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)reloadData;


- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex;


- (void)didClickSelectedItemAtIndex:(NSInteger)index;

@end

@interface JXCategoryListContainerView (Deprecated)

- (instancetype)initWithParentVC:(UIViewController *)parentVC delegate:(id<JXCategoryListContainerViewDelegate>)delegate  JXCategoryViewDeprecated("请使用`- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate`方法，未来版本会删除该方法！");

@end

