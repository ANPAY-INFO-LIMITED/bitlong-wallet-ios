//
//  JXCategoryIndicatorImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorImageView : JXCategoryIndicatorComponentView

@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;

@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;

@property (nonatomic, assign) CGSize indicatorImageViewSize;

@end
