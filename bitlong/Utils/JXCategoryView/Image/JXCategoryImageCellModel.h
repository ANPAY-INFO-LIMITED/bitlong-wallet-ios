//
//  JXCategoryImageCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.

//

#import "JXCategoryIndicatorCellModel.h"

@interface JXCategoryImageCellModel : JXCategoryIndicatorCellModel

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, copy) NSString *imageName;    

@property (nonatomic, strong) NSURL *imageURL;      

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, assign) CGFloat imageCornerRadius;

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

@end
