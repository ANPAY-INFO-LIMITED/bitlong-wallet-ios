//
//  JXCategoryDotView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.

//

#import "JXCategoryTitleView.h"
#import "JXCategoryDotCell.h"
#import "JXCategoryDotCellModel.h"

@interface JXCategoryDotView : JXCategoryTitleView


@property (nonatomic, assign) JXCategoryDotRelativePosition relativePosition;

@property (nonatomic, strong) NSArray <NSNumber *> *dotStates;

@property (nonatomic, assign) CGSize dotSize;

@property (nonatomic, assign) CGFloat dotCornerRadius;

@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, assign) CGPoint dotOffset;
@end
