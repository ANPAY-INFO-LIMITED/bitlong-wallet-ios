//
//  JXCategoryIndicatorTriangleView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorTriangleView : JXCategoryIndicatorComponentView

@end

@interface JXCategoryIndicatorTriangleView (JXDeprecated)

@property (nonatomic, assign) CGSize triangleViewSize JXCategoryViewDeprecated("请使用indicatorHeight和indicatorWidth，未来版本会删除该属性！");

@property (nonatomic, strong) UIColor *triangleViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
