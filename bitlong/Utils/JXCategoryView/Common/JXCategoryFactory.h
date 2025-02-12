//
//  JXCategoryFactory.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXCategoryFactory : NSObject

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;

@end
