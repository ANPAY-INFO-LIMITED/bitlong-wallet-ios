//
//  JXCategoryBaseView.m

//
//  Created by jiaxin on 2018/3/15.

//

#import "JXCategoryBaseView.h"
#import "JXCategoryFactory.h"
#import "JXCategoryViewAnimator.h"

struct DelegateFlags {
    unsigned int didSelectedItemAtIndexFlag : 1;
    unsigned int didClickSelectedItemAtIndexFlag : 1;
    unsigned int didScrollSelectedItemAtIndexFlag : 1;
    unsigned int canClickItemAtIndexFlag : 1;
    unsigned int scrollingFromLeftIndexToRightIndexFlag : 1;
};

@interface JXCategoryBaseView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) JXCategoryCollectionView *collectionView;
@property (nonatomic, assign) struct DelegateFlags delegateFlags;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat innerCellSpacing;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;
@property (nonatomic, strong) JXCategoryViewAnimator *animator;

@property (nonatomic, assign) NSInteger scrollingTargetIndex;
@property (nonatomic, assign, getter=isNeedReloadByBecomeActive) BOOL needReloadByBecomeActive;

@end

@implementation JXCategoryBaseView

- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [self.animator stop];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            if ([((UIViewController *)next) respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
                ((UIViewController *)next).edgesForExtendedLayout = UIRectEdgeNone;
            }
            break;
        }
        next = next.nextResponder;
    }
}

- (void)reloadData {
    [self refreshDataSource];
    [self refreshState];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)reloadCellAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.dataSource.count) {
        return;
    }
    JXCategoryBaseCellModel *cellModel = self.dataSource[index];
    cellModel.selectedType = JXCategoryCellSelectedTypeUnknown;
    [self refreshCellModel:cellModel index:index];
    JXCategoryBaseCell *cell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index selectedType:JXCategoryCellSelectedTypeCode];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    
    
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, floor(self.bounds.size.height));
    [self reloadData];
}

#pragma mark - Setter

- (void)setDelegate:(id<JXCategoryViewDelegate>)delegate {
    _delegate = delegate;

    _delegateFlags.didSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)];
    _delegateFlags.didClickSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)];
    _delegateFlags.didScrollSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)];
    _delegateFlags.canClickItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:canClickItemAtIndex:)];
    _delegateFlags.scrollingFromLeftIndexToRightIndexFlag = [delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    _defaultSelectedIndex = defaultSelectedIndex;

    self.selectedIndex = defaultSelectedIndex;
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;

    self.contentScrollView.scrollsToTop = NO;
    [self.contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryBaseCellModel *cellModel = self.dataSource[indexPath.item];
    cellModel.selectedType = JXCategoryCellSelectedTypeUnknown;
    [(JXCategoryBaseCell *)cell reloadData:cellModel];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isTransitionAnimating = NO;
    for (JXCategoryBaseCellModel *cellModel in self.dataSource) {
        if (cellModel.isTransitionAnimating) {
            isTransitionAnimating = YES;
            break;
        }
    }
    if (!isTransitionAnimating) {
        
        [self clickSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self getContentEdgeInsetLeft], 0, [self getContentEdgeInsetRight]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.dataSource[indexPath.item].cellWidth, self.collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
            
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
        self.lastContentViewContentOffset = contentOffset;
    }
}

#pragma mark - Private

- (CGFloat)getContentEdgeInsetLeft {
    if (self.contentEdgeInsetLeft == JXCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetLeft;
}

- (CGFloat)getContentEdgeInsetRight {
    if (self.contentEdgeInsetRight == JXCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetRight;
}

- (CGFloat)getCellWidthAtIndex:(NSInteger)index {
    return [self preferredCellWidthAtIndex:index] + self.cellWidthIncrement;
}

- (void)clickSelectItemAtIndex:(NSInteger)index {
    if (self.delegateFlags.canClickItemAtIndexFlag && ![self.delegate categoryView:self canClickItemAtIndex:index]) {
        return;
    }

    [self selectCellAtIndex:index selectedType:JXCategoryCellSelectedTypeClick];
}

- (void)scrollSelectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index selectedType:JXCategoryCellSelectedTypeScroll];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if (self.isNeedReloadByBecomeActive) {
        self.needReloadByBecomeActive = NO;
        [self reloadData];
    }
}

@end

@implementation JXCategoryBaseView (UISubclassingBaseHooks)

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    CGFloat x = [self getContentEdgeInsetLeft];
    for (int i = 0; i < targetIndex; i ++) {
        @autoreleasepool {
            JXCategoryBaseCellModel *cellModel = self.dataSource[i];
            CGFloat cellWidth;
            if (cellModel.isTransitionAnimating && cellModel.isCellWidthZoomEnabled) {
                
                if (cellModel.isSelected) {
                    cellWidth = [self getCellWidthAtIndex:cellModel.index]*cellModel.cellWidthSelectedZoomScale;
                }else {
                    cellWidth = [self getCellWidthAtIndex:cellModel.index]*cellModel.cellWidthNormalZoomScale;
                }
            }else {
                cellWidth = cellModel.cellWidth;
            }
            x += cellWidth + self.innerCellSpacing;
        }
    }
    CGFloat width;
    JXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    if (selectedCellModel.isTransitionAnimating && selectedCellModel.isCellWidthZoomEnabled) {
        width = [self getCellWidthAtIndex:selectedCellModel.index]*selectedCellModel.cellWidthSelectedZoomScale;
    }else {
        width = selectedCellModel.cellWidth;
    }
    return CGRectMake(x, 0, width, self.bounds.size.height);
}

- (CGRect)getTargetSelectedCellFrame:(NSInteger)targetIndex selectedType:(JXCategoryCellSelectedType)selectedType
{
    CGFloat x = [self getContentEdgeInsetLeft];
    for (int i = 0; i < targetIndex; i ++) {
        @autoreleasepool {
            JXCategoryBaseCellModel *cellModel = self.dataSource[i];
            x += [self getCellWidthAtIndex:cellModel.index] + self.innerCellSpacing;
        }
    }
    CGFloat cellWidth = 0;
    JXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    if (selectedCellModel.cellWidthZoomEnabled) {
        cellWidth = [self getCellWidthAtIndex:targetIndex]*selectedCellModel.cellWidthSelectedZoomScale;
    }else {
        cellWidth = [self getCellWidthAtIndex:targetIndex];
    }
    return CGRectMake(x, 0, cellWidth, self.bounds.size.height);
}

- (void)initializeData
{
    _dataSource = [NSMutableArray array];
    _selectedIndex = 0;
    _cellWidth = JXCategoryViewAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 20;
    _averageCellSpacingEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _contentEdgeInsetLeft = JXCategoryViewAutomaticDimension;
    _contentEdgeInsetRight = JXCategoryViewAutomaticDimension;
    _lastContentViewContentOffset = CGPointZero;
    _selectedAnimationEnabled = NO;
    _selectedAnimationDuration = 0.25;
    _scrollingTargetIndex = -1;
    _contentScrollViewClickTransitionAnimationEnabled = YES;
    _needReloadByBecomeActive = YES;
}

- (void)initializeViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[JXCategoryCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)refreshDataSource {

}

- (void)refreshState {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.dataSource.count) {
        self.selectedIndex = 0;
    }

    self.innerCellSpacing = self.cellSpacing;
    
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLeft];
    
    CGFloat totalCellWidth = 0;
    for (int i = 0; i < self.dataSource.count; i++) {
        @autoreleasepool {
            JXCategoryBaseCellModel *cellModel = self.dataSource[i];
            cellModel.index = i;
            cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
            cellModel.cellWidthNormalZoomScale = 1;
            cellModel.cellWidthSelectedZoomScale = self.cellWidthZoomScale;
            cellModel.selectedAnimationEnabled = self.selectedAnimationEnabled;
            cellModel.selectedAnimationDuration = self.selectedAnimationDuration;
            cellModel.cellSpacing = self.innerCellSpacing;
            if (i == self.selectedIndex) {
                cellModel.selected = YES;
                cellModel.cellWidthCurrentZoomScale = cellModel.cellWidthSelectedZoomScale;
            }else {
                cellModel.selected = NO;
                cellModel.cellWidthCurrentZoomScale = cellModel.cellWidthNormalZoomScale;
            }
            if (self.isCellWidthZoomEnabled) {
                cellModel.cellWidth = [self getCellWidthAtIndex:i]*cellModel.cellWidthCurrentZoomScale;
            }else {
                cellModel.cellWidth = [self getCellWidthAtIndex:i];
            }
            totalCellWidth += cellModel.cellWidth;
            if (i == self.dataSource.count - 1) {
                totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
            }else {
                totalItemWidth += cellModel.cellWidth + self.innerCellSpacing;
            }
            [self refreshCellModel:cellModel index:i];
        }
    }

    if (self.isAverageCellSpacingEnabled && totalItemWidth < self.bounds.size.width) {
        
        NSInteger cellSpacingItemCount = self.dataSource.count - 1;
        CGFloat totalCellSpacingWidth = self.bounds.size.width - totalCellWidth;
        
        if (self.contentEdgeInsetLeft == JXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetLeft;
        }
        
        if (self.contentEdgeInsetRight == JXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetRight;
        }

        
//        CGFloat cellSpacing = 0;
//        if (cellSpacingItemCount > 0) {
//            cellSpacing = totalCellSpacingWidth/cellSpacingItemCount;
//        }
//        self.innerCellSpacing = cellSpacing;
        [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellSpacing = self.innerCellSpacing;
        }];
    }

    
    
    __block CGFloat frameXOfSelectedCell = self.innerCellSpacing;
    __block CGFloat selectedCellWidth = 0;
    totalItemWidth = [self getContentEdgeInsetLeft];
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += cellModel.cellWidth + self.innerCellSpacing;
        }else if (idx == self.selectedIndex) {
            selectedCellWidth = cellModel.cellWidth;
        }
        if (idx == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else {
            totalItemWidth += cellModel.cellWidth + self.innerCellSpacing;
        }
    }];

    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];
    

    if (CGRectEqualToRect(self.contentScrollView.frame, CGRectZero) && self.contentScrollView.superview != nil) {
        
        
        UIView *parentView = self.contentScrollView.superview;
        while (parentView != nil && CGRectEqualToRect(parentView.frame, CGRectZero)) {
            parentView = parentView.superview;
        }
        [parentView setNeedsLayout];
        [parentView layoutIfNeeded];
    }
    
    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:NO];
}

- (BOOL)selectCellAtIndex:(NSInteger)targetIndex selectedType:(JXCategoryCellSelectedType)selectedType {
    if (targetIndex < 0 || targetIndex >= self.dataSource.count) {
        return NO;
    }

    self.needReloadByBecomeActive = NO;
    if (self.selectedIndex == targetIndex) {
        
        if (selectedType == JXCategoryCellSelectedTypeClick) {
            if (self.delegateFlags.didClickSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didClickSelectedItemAtIndex:targetIndex];
            }
        }else if (selectedType == JXCategoryCellSelectedTypeScroll) {
            if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
            }
        }
        if (self.delegateFlags.didSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
        }
        self.scrollingTargetIndex = -1;
        return NO;
    }

    
    JXCategoryBaseCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    lastCellModel.selectedType = selectedType;
    JXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    selectedCellModel.selectedType = selectedType;
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];

    
    JXCategoryBaseCell *lastCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];
    JXCategoryBaseCell *selectedCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];

    if (self.scrollingTargetIndex != -1 && self.scrollingTargetIndex != targetIndex) {
        JXCategoryBaseCellModel *scrollingTargetCellModel = self.dataSource[self.scrollingTargetIndex];
        scrollingTargetCellModel.selected = NO;
        scrollingTargetCellModel.selectedType = selectedType;
        [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:scrollingTargetCellModel];
        JXCategoryBaseCell *scrollingTargetCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.scrollingTargetIndex inSection:0]];
        [scrollingTargetCell reloadData:scrollingTargetCellModel];
    }

    if (self.isCellWidthZoomEnabled) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.selectedAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        });
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }

    if (selectedType == JXCategoryCellSelectedTypeClick ||
        selectedType == JXCategoryCellSelectedTypeCode) {
        [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:self.isContentScrollViewClickTransitionAnimationEnabled];
    }

    self.selectedIndex = targetIndex;
    if (selectedType == JXCategoryCellSelectedTypeClick) {
        if (self.delegateFlags.didClickSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didClickSelectedItemAtIndex:targetIndex];
        }
    }else if(selectedType == JXCategoryCellSelectedTypeScroll) {
        if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
        }
    }
    if (self.delegateFlags.didSelectedItemAtIndexFlag) {
        [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
    }
    self.scrollingTargetIndex = -1;

    return YES;
}


- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    selectedCellModel.selected = YES;
    unselectedCellModel.selected = NO;

    if (self.isCellWidthZoomEnabled) {
        if (selectedCellModel.selectedType == JXCategoryCellSelectedTypeCode ||
            selectedCellModel.selectedType == JXCategoryCellSelectedTypeClick) {
            self.animator = [[JXCategoryViewAnimator alloc] init];
            self.animator.duration = self.selectedAnimationDuration;
            __weak typeof(self) weakSelf = self;
            self.animator.progressCallback = ^(CGFloat percent) {
                selectedCellModel.transitionAnimating = YES;
                unselectedCellModel.transitionAnimating = YES;
                selectedCellModel.cellWidthCurrentZoomScale = [JXCategoryFactory interpolationFrom:selectedCellModel.cellWidthNormalZoomScale to:selectedCellModel.cellWidthSelectedZoomScale percent:percent];
                selectedCellModel.cellWidth = [weakSelf getCellWidthAtIndex:selectedCellModel.index] * selectedCellModel.cellWidthCurrentZoomScale;
                unselectedCellModel.cellWidthCurrentZoomScale = [JXCategoryFactory interpolationFrom:unselectedCellModel.cellWidthSelectedZoomScale to:unselectedCellModel.cellWidthNormalZoomScale percent:percent];
                unselectedCellModel.cellWidth = [weakSelf getCellWidthAtIndex:unselectedCellModel.index] * unselectedCellModel.cellWidthCurrentZoomScale;
                [weakSelf.collectionView.collectionViewLayout invalidateLayout];
            };
            self.animator.completeCallback = ^{
                selectedCellModel.transitionAnimating = NO;
                unselectedCellModel.transitionAnimating = NO;
            };
            [self.animator start];
        }else {
            selectedCellModel.cellWidthCurrentZoomScale = selectedCellModel.cellWidthSelectedZoomScale;
            selectedCellModel.cellWidth = [self getCellWidthAtIndex:selectedCellModel.index] * selectedCellModel.cellWidthCurrentZoomScale;
            unselectedCellModel.cellWidthCurrentZoomScale = unselectedCellModel.cellWidthNormalZoomScale;
            unselectedCellModel.cellWidth = [self getCellWidthAtIndex:unselectedCellModel.index] * unselectedCellModel.cellWidthCurrentZoomScale;
        }
    }
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    @autoreleasepool {
        CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
            if (ratio > self.dataSource.count - 1 || ratio < 0) {
                
                return;
            }
            if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
                
                return;
            }
            CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
            if (contentOffset.x == maxContentOffsetX && self.selectedIndex == self.dataSource.count - 1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
                
                return;
            }
            ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
            NSInteger baseIndex = floorf(ratio);
            CGFloat remainderRatio = ratio - baseIndex;

            if (remainderRatio == 0) {
                
                
                if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
                    [self scrollSelectItemAtIndex:baseIndex];
                }
            }else {
                self.needReloadByBecomeActive = YES;
                if (self.animator.isExecuting) {
                    [self.animator invalid];
                    
                    for (JXCategoryBaseCellModel *model in self.dataSource) {
                        @autoreleasepool {
                            if (model.isSelected) {
                                model.cellWidthCurrentZoomScale = model.cellWidthSelectedZoomScale;
                                model.cellWidth = [self getCellWidthAtIndex:model.index] * model.cellWidthCurrentZoomScale;
                            }else {
                                model.cellWidthCurrentZoomScale = model.cellWidthNormalZoomScale;
                                model.cellWidth = [self getCellWidthAtIndex:model.index] * model.cellWidthCurrentZoomScale;
                            }
                        }
                    }
                }
                
                if (fabs(ratio - self.selectedIndex) > 1) {
                    NSInteger targetIndex = baseIndex;
                    if (ratio < self.selectedIndex) {
                        targetIndex = baseIndex + 1;
                    }
        //            [self scrollSelectItemAtIndex:targetIndex];
                }

                if (self.selectedIndex == baseIndex) {
                    self.scrollingTargetIndex = baseIndex + 1;
                }else {
                    self.scrollingTargetIndex = baseIndex;
                }

                if (self.isCellWidthZoomEnabled && self.isCellWidthZoomScrollGradientEnabled) {
                    JXCategoryBaseCellModel *leftCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex];
                    JXCategoryBaseCellModel *rightCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex + 1];
                    leftCellModel.cellWidthCurrentZoomScale = [JXCategoryFactory interpolationFrom:leftCellModel.cellWidthSelectedZoomScale to:leftCellModel.cellWidthNormalZoomScale percent:remainderRatio];
                    leftCellModel.cellWidth = [self getCellWidthAtIndex:leftCellModel.index] * leftCellModel.cellWidthCurrentZoomScale;
                    rightCellModel.cellWidthCurrentZoomScale = [JXCategoryFactory interpolationFrom:rightCellModel.cellWidthNormalZoomScale to:rightCellModel.cellWidthSelectedZoomScale percent:remainderRatio];
                    rightCellModel.cellWidth = [self getCellWidthAtIndex:rightCellModel.index] * rightCellModel.cellWidthCurrentZoomScale;
                    [self.collectionView.collectionViewLayout invalidateLayout];
                }

                if (self.delegateFlags.scrollingFromLeftIndexToRightIndexFlag) {
                    [self.delegate categoryView:self scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio];
                }
            }
    }
    
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return 0;
}

- (Class)preferredCellClass {
    return JXCategoryBaseCell.class;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {

}

@end
