//
//  JXCategoryCollectionView.m

//
//  Created by jiaxin on 2018/3/21.

//

#import "JXCategoryCollectionView.h"

@interface JXCategoryCollectionView ()<UIGestureRecognizerDelegate>
@end

@implementation JXCategoryCollectionView

- (void)setIndicators:(NSArray<UIView<JXCategoryIndicatorProtocol> *> *)indicators {
    for (UIView *indicator in _indicators) {
        @autoreleasepool {
            
            [indicator removeFromSuperview];
        }
    }

    _indicators = indicators;

    for (UIView *indicator in indicators) {
        @autoreleasepool {
            [self addSubview:indicator];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    for (UIView<JXCategoryIndicatorProtocol> *view in self.indicators) {
        @autoreleasepool {
            [self sendSubviewToBack:view];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.gestureDelegate && [self.gestureDelegate respondsToSelector:@selector(categoryCollectionView:gestureRecognizerShouldBegin:)]) {
        return [self.gestureDelegate categoryCollectionView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.gestureDelegate && [self.gestureDelegate respondsToSelector:@selector(categoryCollectionView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.gestureDelegate categoryCollectionView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

@end
