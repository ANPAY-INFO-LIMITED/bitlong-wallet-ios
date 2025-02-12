//
//  JXCategoryImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.

//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryImageCell.h"
#import "JXCategoryImageCellModel.h"

@interface JXCategoryImageView : JXCategoryIndicatorView

@property (nonatomic, strong) NSArray <NSString *>*imageNames;

@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;

@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;

@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);   

@property (nonatomic, assign) CGSize imageSize;     

@property (nonatomic, assign) CGFloat imageCornerRadius; 

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;     

@property (nonatomic, assign) CGFloat imageZoomScale;    

@end
