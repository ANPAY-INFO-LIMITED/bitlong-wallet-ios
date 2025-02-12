//
//  JXCategoryTitleCell.m

//
//  Created by jiaxin on 2018/3/15.

//

#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"
#import "JXCategoryFactory.h"

@interface JXCategoryTitleCell ()
@property (nonatomic, strong) CALayer *titleMaskLayer;
@property (nonatomic, strong) CALayer *maskTitleMaskLayer;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterY;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterY;
@end

@implementation JXCategoryTitleCell

- (void)initializeViews
{
    [super initializeViews];

    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];

    self.titleLabelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.titleLabelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.titleLabelCenterX.active = YES;
    self.titleLabelCenterY.active = YES;

    _titleMaskLayer = [CALayer layer];
    self.titleMaskLayer.backgroundColor = [UIColor redColor].CGColor;

    _maskTitleLabel = [[UILabel alloc] init];
    self.maskTitleLabel.hidden = YES;
    self.maskTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];

    self.maskTitleLabelCenterX = [NSLayoutConstraint constraintWithItem:self.maskTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.maskTitleLabelCenterY = [NSLayoutConstraint constraintWithItem:self.maskTitleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.maskTitleLabelCenterX.active = YES;
    self.maskTitleLabelCenterY.active = YES;

    _maskTitleMaskLayer = [CALayer layer];
    self.maskTitleMaskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskTitleMaskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)self.cellModel;
    switch (myCellModel.titleLabelAnchorPointStyle) {
        case JXCategoryTitleLabelAnchorPointStyleCenter:
            self.titleLabelCenterY.constant = 0 + myCellModel.titleLabelVerticalOffset;
            break;
        case JXCategoryTitleLabelAnchorPointStyleTop:
        {
            CGFloat percent = (myCellModel.titleLabelCurrentZoomScale - myCellModel.titleLabelNormalZoomScale)/(myCellModel.titleLabelSelectedZoomScale - myCellModel.titleLabelNormalZoomScale);
            self.titleLabelCenterY.constant = -self.titleLabel.bounds.size.height/2 - myCellModel.titleLabelVerticalOffset - myCellModel.titleLabelZoomSelectedVerticalOffset*percent;
        }
            break;
        case JXCategoryTitleLabelAnchorPointStyleBottom:
        {
            CGFloat percent = (myCellModel.titleLabelCurrentZoomScale - myCellModel.titleLabelNormalZoomScale)/(myCellModel.titleLabelSelectedZoomScale - myCellModel.titleLabelNormalZoomScale);
            self.titleLabelCenterY.constant = self.titleLabel.bounds.size.height/2 + myCellModel.titleLabelVerticalOffset + myCellModel.titleLabelZoomSelectedVerticalOffset*percent;
        }
            break;
        default:
            break;
    }
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    self.titleLabel.numberOfLines = myCellModel.titleNumberOfLines;
    self.maskTitleLabel.numberOfLines = myCellModel.titleNumberOfLines;
    switch (myCellModel.titleLabelAnchorPointStyle) {
        case JXCategoryTitleLabelAnchorPointStyleCenter:
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 0.5);
            break;
        case JXCategoryTitleLabelAnchorPointStyleTop:
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 0);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 0);
            break;
        case JXCategoryTitleLabelAnchorPointStyleBottom:
            self.titleLabel.layer.anchorPoint = CGPointMake(0.5, 1);
            self.maskTitleLabel.layer.anchorPoint = CGPointMake(0.5, 1);
            break;
        default:
            break;
    }

    if (myCellModel.isTitleLabelZoomEnabled) {
        
        UIFont *maxScaleFont = [UIFont fontWithDescriptor:myCellModel.titleFont.fontDescriptor size:myCellModel.titleFont.pointSize*myCellModel.titleLabelSelectedZoomScale];
        CGFloat baseScale = myCellModel.titleFont.lineHeight/maxScaleFont.lineHeight;
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleZoomAnimationBlock:myCellModel baseScale:baseScale];
            [self addSelectedAnimationBlock:block];
        }else {
            self.titleLabel.font = maxScaleFont;
            self.maskTitleLabel.font = maxScaleFont;
            CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*myCellModel.titleLabelCurrentZoomScale, baseScale*myCellModel.titleLabelCurrentZoomScale);
            self.titleLabel.transform = currentTransform;
            self.maskTitleLabel.transform = currentTransform;
        }
    }else {
        if (myCellModel.isSelected) {
            self.titleLabel.font = myCellModel.titleSelectedFont;
            self.maskTitleLabel.font = myCellModel.titleSelectedFont;
        }else {
            self.titleLabel.font = myCellModel.titleFont;
            self.maskTitleLabel.font = myCellModel.titleFont;
        }
    }

    NSString *titleString = myCellModel.title ? myCellModel.title : @"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    if (myCellModel.isTitleLabelStrokeWidthEnabled) {
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleStrokeWidthAnimationBlock:myCellModel attributedString:attributedString];
            [self addSelectedAnimationBlock:block];
        }else {
            [attributedString addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, titleString.length)];
            self.titleLabel.attributedText = attributedString;
            self.maskTitleLabel.attributedText = attributedString;
        }
    }else {
        self.titleLabel.attributedText = attributedString;
        self.maskTitleLabel.attributedText = attributedString;
    }

    if (myCellModel.isTitleLabelMaskEnabled) {
        self.maskTitleLabel.hidden = NO;
        self.titleLabel.textColor = myCellModel.titleNormalColor;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;
        [self.contentView setNeedsLayout];
        [self.contentView layoutIfNeeded];

        CGRect topMaskframe = myCellModel.backgroundViewMaskFrame;
        
        
        topMaskframe.origin.y = 0;
        CGRect bottomMaskFrame = topMaskframe;
        CGFloat maskStartX = 0;
        if (self.maskTitleLabel.bounds.size.width >= self.bounds.size.width) {
            topMaskframe.origin.x -= (self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
            bottomMaskFrame.size.width = self.maskTitleLabel.bounds.size.width;
            maskStartX = -(self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
        }else {
            bottomMaskFrame.size.width = self.bounds.size.width;
            topMaskframe.origin.x -= (self.bounds.size.width -self.maskTitleLabel.bounds.size.width)/2;
            maskStartX = 0;
        }
        bottomMaskFrame.origin.x = topMaskframe.origin.x;
        if (topMaskframe.origin.x > maskStartX) {
            bottomMaskFrame.origin.x = topMaskframe.origin.x - bottomMaskFrame.size.width;
        }else {
            bottomMaskFrame.origin.x = CGRectGetMaxX(topMaskframe);
        }

        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (topMaskframe.size.width > 0 && CGRectIntersectsRect(topMaskframe, self.maskTitleLabel.frame)) {
            self.titleLabel.layer.mask = self.titleMaskLayer;
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleMaskLayer.frame = bottomMaskFrame;
        }else {
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleLabel.layer.mask = nil;
        }
        [CATransaction commit];
    }else {
        self.maskTitleLabel.hidden = YES;
        self.titleLabel.layer.mask = nil;
        if (myCellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleColorAnimationBlock:myCellModel];
            [self addSelectedAnimationBlock:block];
        }else {
           self.titleLabel.textColor = myCellModel.titleCurrentColor;
        }
    }

    [self startSelectedAnimationIfNeeded:myCellModel];
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(JXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalZoomScale to:cellModel.titleLabelSelectedZoomScale percent:percent];
        }else {
            
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedZoomScale to:cellModel.titleLabelNormalZoomScale percent:percent];
        }
        CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*cellModel.titleLabelCurrentZoomScale, baseScale*cellModel.titleLabelCurrentZoomScale);
        weakSelf.titleLabel.transform = currentTransform;
        weakSelf.maskTitleLabel.transform = currentTransform;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(JXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalStrokeWidth to:cellModel.titleLabelSelectedStrokeWidth percent:percent];
        }else {
            
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedStrokeWidth to:cellModel.titleLabelNormalStrokeWidth percent:percent];
        }
        [attributedString addAttribute:NSStrokeWidthAttributeName value:@(cellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, attributedString.string.length)];
        weakSelf.titleLabel.attributedText = attributedString;
        weakSelf.maskTitleLabel.attributedText = attributedString;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.isSelected) {
            
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleNormalColor to:cellModel.titleSelectedColor percent:percent];
        }else {
            
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleSelectedColor to:cellModel.titleNormalColor percent:percent];
        }
        weakSelf.titleLabel.textColor = cellModel.titleCurrentColor;
    };
}


@end
