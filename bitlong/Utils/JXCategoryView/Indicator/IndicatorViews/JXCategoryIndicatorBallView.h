//
//  JXCategoryIndicatorBallView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/21.

//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBallView : JXCategoryIndicatorComponentView


@property (nonatomic, assign) CGFloat ballScrollOffsetX;

@end

@interface JXCategoryIndicatorBallView (JXDeprecated)

@property (nonatomic, assign) CGSize ballViewSize JXCategoryViewDeprecated("请使用indicatorHeight和indicatorWidth，未来版本会删除该属性！");
@property (nonatomic, strong) UIColor *ballViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
