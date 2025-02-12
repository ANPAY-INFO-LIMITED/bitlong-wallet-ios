//
//  JXCategoryCollectionView.h

//
//  Created by jiaxin on 2018/3/21.

//

#import <UIKit/UIKit.h>
#import "JXCategoryIndicatorProtocol.h"
@class JXCategoryCollectionView;

@protocol JXCategoryCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)categoryCollectionView:(JXCategoryCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)categoryCollectionView:(JXCategoryCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

@interface JXCategoryCollectionView : UICollectionView

@property (nonatomic, strong) NSArray <UIView<JXCategoryIndicatorProtocol> *> *indicators;
@property (nonatomic, weak) id<JXCategoryCollectionViewGestureDelegate> gestureDelegate;

@end
