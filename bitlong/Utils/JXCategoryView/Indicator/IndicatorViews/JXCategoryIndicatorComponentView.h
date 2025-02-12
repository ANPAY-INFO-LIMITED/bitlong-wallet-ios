//
//  JXCategoryComponentBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import <UIKit/UIKit.h>
#import "JXCategoryIndicatorProtocol.h"
#import "JXCategoryViewDefines.h"

@interface JXCategoryIndicatorComponentView : UIView <JXCategoryIndicatorProtocol>

@property (nonatomic, assign) JXCategoryComponentPosition componentPosition;

@property (nonatomic, assign) CGFloat indicatorWidth;

@property (nonatomic, assign) CGFloat indicatorWidthIncrement;

@property (nonatomic, assign) CGFloat indicatorHeight;

@property (nonatomic, assign) CGFloat indicatorCornerRadius;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, assign) CGFloat verticalMargin;

@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;

@property (nonatomic, assign) JXCategoryIndicatorScrollStyle scrollStyle;

@property (nonatomic, assign) NSTimeInterval scrollAnimationDuration;

- (CGFloat)indicatorWidthValue:(CGRect)cellFrame;

- (CGFloat)indicatorHeightValue:(CGRect)cellFrame;

- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame;

@end
