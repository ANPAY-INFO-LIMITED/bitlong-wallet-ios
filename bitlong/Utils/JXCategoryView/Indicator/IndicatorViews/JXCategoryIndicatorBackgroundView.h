//
//  JXCategoryIndicatorBackgroundView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBackgroundView : JXCategoryIndicatorComponentView


@end

@interface JXCategoryIndicatorBackgroundView (JXDeprecated)

@property (nonatomic, assign) CGFloat backgroundViewWidth JXCategoryViewDeprecated("请使用indicatorWidth，未来版本会删除该属性！");
@property (nonatomic, assign) CGFloat backgroundViewWidthIncrement JXCategoryViewDeprecated("请使用indicatorWidthIncrement，未来版本会删除该属性！");
@property (nonatomic, assign) CGFloat backgroundViewHeight JXCategoryViewDeprecated("请使用indicatorHeight，未来版本会删除该属性！");
@property (nonatomic, assign) CGFloat backgroundViewCornerRadius JXCategoryViewDeprecated("请使用indicatorCornerRadius，未来版本会删除该属性！");
@property (nonatomic, strong) UIColor *backgroundViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
