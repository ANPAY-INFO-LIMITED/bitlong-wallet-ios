//
//  JXCategoryTitleVerticalZoomView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/14.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"

NS_ASSUME_NONNULL_BEGIN


@interface JXCategoryTitleVerticalZoomView : JXCategoryTitleView

@property (nonatomic, assign) CGFloat maxVerticalFontScale; 
@property (nonatomic, assign) CGFloat minVerticalFontScale; 
@property (nonatomic, assign) CGFloat maxVerticalCellSpacing;   
@property (nonatomic, assign) CGFloat minVerticalCellSpacing;   

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
