//
//  JXCategoryIndicatorLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import "JXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorLineStyle) {
    JXCategoryIndicatorLineStyle_Normal             = 0,
    JXCategoryIndicatorLineStyle_Lengthen           = 1,
    JXCategoryIndicatorLineStyle_LengthenOffset     = 2,
    
    JXCategoryIndicatorLineStyle_JD               JXCategoryViewDeprecated("请使用JXCategoryIndicatorLineStyle_Lengthen，未来版本会删除该属性！")  = 1,    // Deprecated. Use JXCategoryIndicatorLineStyle_Lengthen
    JXCategoryIndicatorLineStyle_IQIYI            JXCategoryViewDeprecated("请使用JXCategoryIndicatorLineStyle_LengthenOffset，未来版本会删除该属性！")  = 2,    // Deprecated. Use JXCategoryIndicatorLineStyle_LengthenOffset
};

@interface JXCategoryIndicatorLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) JXCategoryIndicatorLineStyle lineStyle;

@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@end


@interface JXCategoryIndicatorLineView (JXDeprecated)
@property (nonatomic, assign) CGFloat indicatorLineViewHeight JXCategoryViewDeprecated("请使用indicatorHeight，未来版本会删除该属性！");
@property (nonatomic, assign) CGFloat indicatorLineWidth JXCategoryViewDeprecated("请使用indicatorWidth，未来版本会删除该属性！");
@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius JXCategoryViewDeprecated("请使用indicatorCornerRadius，未来版本会删除该属性！");
@property (nonatomic, strong) UIColor *indicatorLineViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
