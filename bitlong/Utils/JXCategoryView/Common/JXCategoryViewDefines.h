//
//  JXCategoryViewDefines.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat JXCategoryViewAutomaticDimension = -1;

typedef void(^JXCategoryCellSelectedAnimationBlock)(CGFloat percent);

typedef NS_ENUM(NSUInteger, JXCategoryComponentPosition) {
    JXCategoryComponentPosition_Bottom,
    JXCategoryComponentPosition_Top,
};


typedef NS_ENUM(NSUInteger, JXCategoryCellSelectedType) {
    JXCategoryCellSelectedTypeUnknown,          
    JXCategoryCellSelectedTypeClick,            
    JXCategoryCellSelectedTypeCode,             
    JXCategoryCellSelectedTypeScroll            
};

typedef NS_ENUM(NSUInteger, JXCategoryTitleLabelAnchorPointStyle) {
    JXCategoryTitleLabelAnchorPointStyleCenter,
    JXCategoryTitleLabelAnchorPointStyleTop,
    JXCategoryTitleLabelAnchorPointStyleBottom,
};

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorScrollStyle) {
    JXCategoryIndicatorScrollStyleSimple,                   
    JXCategoryIndicatorScrollStyleSameAsUserScroll,         
};

#define JXCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
