//
//  JXCategoryNumberView.h
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.

//

#import "JXCategoryTitleView.h"
#import "JXCategoryNumberCell.h"
#import "JXCategoryNumberCellModel.h"

@interface JXCategoryNumberView : JXCategoryTitleView

@property (nonatomic, strong) NSArray <NSNumber *> *counts;

@property (nonatomic, copy) NSString *(^numberStringFormatterBlock)(NSInteger number);

@property (nonatomic, strong) UIFont *numberLabelFont;

@property (nonatomic, strong) UIColor *numberBackgroundColor;

@property (nonatomic, strong) UIColor *numberTitleColor;

@property (nonatomic, assign) CGFloat numberLabelWidthIncrement;

@property (nonatomic, assign) CGFloat numberLabelHeight;

@property (nonatomic, assign) CGPoint numberLabelOffset;

@end
