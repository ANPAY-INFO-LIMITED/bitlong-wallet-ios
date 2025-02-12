//
//  JXCategoryImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.

//

#import "JXCategoryTitleView.h"
#import "JXCategoryTitleImageCell.h"
#import "JXCategoryTitleImageCellModel.h"

@interface JXCategoryTitleImageView : JXCategoryTitleView


@property (nonatomic, strong) NSArray <NSString *>*imageNames;

@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;

@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;

@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;

@property (nonatomic, strong) NSArray <NSNumber *> *imageTypes;

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, strong) NSArray <NSValue *>* imageSizes;

@property (nonatomic, assign) CGFloat titleImageSpacing;

@property (nonatomic, assign) CGFloat titleImageDistance;

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

@property (nonatomic, assign) CGFloat imageBordeWidth;
@property (nonatomic, strong) UIColor * imageBordeColor;

@end
