//
//  JXCategoryListCollectionContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.

//

#import "JXCategoryListCollectionContainerView.h"
#import <objc/runtime.h>

@interface JXCategoryListCollectionContainerView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<JXCategoryListCollectionContainerViewDataSource> dataSource;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListCollectionContentViewDelegate>> *validListDict;
@property (nonatomic, assign) BOOL willRemoveFromWindow;
@property (nonatomic, assign) BOOL isFirstMoveToWindow;
@property (nonatomic, strong) JXCategoryListCollectionContainerView *retainedSelf;
@property (nonatomic, assign) BOOL shouldRefreshSelectedContentOffset;
@end

@implementation JXCategoryListCollectionContainerView

- (instancetype)initWithDataSource:(id<JXCategoryListCollectionContainerViewDataSource>)dataSource {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.dataSource = dataSource;
        _isFirstMoveToWindow = YES;
        _shouldRefreshSelectedContentOffset = YES;
        _validListDict = [NSMutableDictionary dictionary];
        [self initializeViews];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (self.isFirstMoveToWindow) {
        
        self.isFirstMoveToWindow = NO;
        return;
    }
    
    
    if (newWindow == nil) {
        self.willRemoveFromWindow = YES;
        
        self.retainedSelf = self;
        [self performSelector:@selector(currentListDidDisappear) withObject:nil afterDelay:0.02];
    }else {
        if (self.willRemoveFromWindow) {
            self.willRemoveFromWindow = NO;
            self.retainedSelf = nil;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(currentListDidDisappear) object:nil];
        }else {
            [self currentListDidAppear];
        }
    }
}

- (void)initializeViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(collectionViewClassInListContainerView:)] &&
        [[self.dataSource collectionViewClassInListContainerView:self] isKindOfClass:object_getClass([UICollectionView class])]) {
        _collectionView = (UICollectionView *)[[[self.dataSource collectionViewClassInListContainerView:self] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }else {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.bounces = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
}

- (void)reloadData {
    for (id<JXCategoryListCollectionContentViewDelegate> list in _validListDict.allValues) {
        @autoreleasepool {
            [[list listView] removeFromSuperview];
        }
    }
    [_validListDict removeAllObjects];

    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!CGRectEqualToRect(self.collectionView.frame, CGRectZero) &&  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        self.shouldRefreshSelectedContentOffset = YES;
    }
    self.collectionView.frame = self.bounds;
    if (self.shouldRefreshSelectedContentOffset) {
        self.shouldRefreshSelectedContentOffset = NO;
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width*self.currentIndex, 0) animated:NO];
    }
}

#pragma mark - Setter

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.currentIndex = defaultSelectedIndex;
}

#pragma mark - Private

- (void)currentListDidAppear {
    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidDisappear {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(self.currentIndex)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    self.willRemoveFromWindow = NO;
    self.retainedSelf = nil;
}

- (void)listDidAppear:(NSInteger)index {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    if (count <= 0 || index >= count) {
        return;
    }
    self.currentIndex = index;

    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    if (count <= 0 || index >= count) {
        return;
    }
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *subview in cell.contentView.subviews) {
        @autoreleasepool {
            [subview removeFromSuperview];
        }
    }
    self.currentIndex = indexPath.item;
    BOOL canInitList = YES;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        canInitList = [self.dataSource listContainerView:self canInitListAtIndex:indexPath.item];
    }
    if (canInitList) {
        id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
        if (list == nil && self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:initListForIndex:)]) {
            list = [self.dataSource listContainerView:self initListForIndex:indexPath.item];
            if (list != nil) {
                _validListDict[@(indexPath.item)] = list;
            }
        }
        if (list != nil) {
            [list listView].frame = cell.contentView.bounds;
            [cell.contentView addSubview:[list listView]];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JXCategoryListCollectionScrollViewScrollViewDidScroll:)]) {
        [self.delegate JXCategoryListCollectionScrollViewScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JXCategoryListCollectionScrollViewWillBeginDecelerating:)]) {
        [self.delegate JXCategoryListCollectionScrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(JXCategoryListCollectionScrollViewDidEndDecelerating:)]) {
        [self.delegate JXCategoryListCollectionScrollViewDidEndDecelerating:scrollView];
    }
}
@end
