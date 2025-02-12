//
//  JXCategoryIndicatorDotLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.

//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorDotLineView : JXCategoryIndicatorComponentView


@property (nonatomic, assign) CGFloat lineWidth;

@end

@interface JXCategoryIndicatorDotLineView (JXDeprecated)

@property (nonatomic, assign) CGSize dotSize JXCategoryViewDeprecated("请使用indicatorHeight和indicatorWidth，未来版本会删除该属性！");
@property (nonatomic, strong) UIColor *dotLineViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
