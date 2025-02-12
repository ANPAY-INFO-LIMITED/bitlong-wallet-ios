//
//  JXCategoryBaseCell.m

//
//  Created by jiaxin on 2018/3/15.

//

#import "JXCategoryBaseCell.h"

@interface JXCategoryBaseCell ()
@property (nonatomic, strong) JXCategoryBaseCellModel *cellModel;
@property (nonatomic, strong) JXCategoryViewAnimator *animator;
@property (nonatomic, strong) NSMutableArray <JXCategoryCellSelectedAnimationBlock> *animationBlockArray;
@end

@implementation JXCategoryBaseCell

- (void)dealloc
{
    [self.animator stop];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self.animator stop];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _animationBlockArray = [NSMutableArray array];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    self.cellModel = cellModel;

    if (cellModel.isSelectedAnimationEnabled) {
        [self.animationBlockArray removeLastObject];
        if ([self checkCanStartSelectedAnimation:cellModel]) {
            _animator = [[JXCategoryViewAnimator alloc] init];
            self.animator.duration = cellModel.selectedAnimationDuration;
        }else {
            [self.animator stop];
        }
    }
}

- (BOOL)checkCanStartSelectedAnimation:(JXCategoryBaseCellModel *)cellModel {
    if (cellModel.selectedType == JXCategoryCellSelectedTypeCode || cellModel.selectedType == JXCategoryCellSelectedTypeClick) {
        return YES;
    }
    return NO;
}

- (void)addSelectedAnimationBlock:(JXCategoryCellSelectedAnimationBlock)block {
    [self.animationBlockArray addObject:block];
}

- (void)startSelectedAnimationIfNeeded:(JXCategoryBaseCellModel *)cellModel {
    if (cellModel.isSelectedAnimationEnabled && [self checkCanStartSelectedAnimation:cellModel]) {
        
        cellModel.transitionAnimating = YES;
        __weak typeof(self)weakSelf = self;
        self.animator.progressCallback = ^(CGFloat percent) {
            for (JXCategoryCellSelectedAnimationBlock block in weakSelf.animationBlockArray) {
                block(percent);
            }
        };
        self.animator.completeCallback = ^{
            cellModel.transitionAnimating = NO;
            [weakSelf.animationBlockArray removeAllObjects];
        };
        [self.animator start];
    }
}

@end
