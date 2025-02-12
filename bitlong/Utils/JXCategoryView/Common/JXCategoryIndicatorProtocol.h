//
//  JXCategoryIndicatorProtocol.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
#import "JXCategoryIndicatorParamsModel.h"

@protocol JXCategoryIndicatorProtocol <NSObject>


- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model;

- (void)jx_contentScrollViewDidScroll:(JXCategoryIndicatorParamsModel *)model;

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model;

@end
