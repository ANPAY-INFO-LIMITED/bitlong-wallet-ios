//
//  JXCategoryView.h

//
//  Created by jiaxin on 2018/3/15.

//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"
#import "JXCategoryViewDefines.h"

@class JXCategoryTitleView;

@protocol JXCategoryTitleViewDataSource <NSObject>
@optional


- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title;
@end


@interface JXCategoryTitleView : JXCategoryIndicatorView

@property (nonatomic, weak) id<JXCategoryTitleViewDataSource> titleDataSource;

@property (nonatomic, strong) NSArray <NSString *>*titles;

@property (nonatomic, assign) NSInteger titleNumberOfLines; 

@property (nonatomic, strong) UIColor *titleColor;      

@property (nonatomic, strong) UIColor *titleSelectedColor;      

@property (nonatomic, strong) UIFont *titleFont;    

@property (nonatomic, strong) UIFont *titleSelectedFont;    

@property (nonatomic, assign, getter=isTitleColorGradientEnabled) BOOL titleColorGradientEnabled;   

@property (nonatomic, assign, getter=isTitleLabelMaskEnabled) BOOL titleLabelMaskEnabled;   

//----------------------titleLabelZoomEnabled-----------------------//
@property (nonatomic, assign, getter=isTitleLabelZoomEnabled) BOOL titleLabelZoomEnabled;     

@property (nonatomic, assign, getter=isTitleLabelZoomScrollGradientEnabled) BOOL titleLabelZoomScrollGradientEnabled;     

@property (nonatomic, assign) CGFloat titleLabelZoomScale;    

@property (nonatomic, assign) CGFloat titleLabelZoomSelectedVerticalOffset; 

//----------------------titleLabelStrokeWidth-----------------------//
@property (nonatomic, assign, getter=isTitleLabelStrokeWidthEnabled) BOOL titleLabelStrokeWidthEnabled;     

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;    


@property (nonatomic, assign) CGFloat titleLabelVerticalOffset; 

@property (nonatomic, assign) JXCategoryTitleLabelAnchorPointStyle titleLabelAnchorPointStyle;  
@end
