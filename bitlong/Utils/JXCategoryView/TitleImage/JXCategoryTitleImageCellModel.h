//
//  JXCategoryTitleImageCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.

//

#import "JXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, JXCategoryTitleImageType) {
    JXCategoryTitleImageType_TopImage = 0,
    JXCategoryTitleImageType_LeftImage,
    JXCategoryTitleImageType_BottomImage,
    JXCategoryTitleImageType_RightImage,
    JXCategoryTitleImageType_BelowImage,
    JXCategoryTitleImageType_OnlyImage,
    JXCategoryTitleImageType_OnlyTitle,
};

@interface JXCategoryTitleImageCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) JXCategoryTitleImageType imageType;

@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@property (nonatomic, copy) NSString *imageName;    

@property (nonatomic, strong) NSURL *imageURL;      

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@property (nonatomic, assign) CGSize imageSize;     

@property (nonatomic, assign) CGFloat titleImageSpacing;    
@property (nonatomic, assign) CGFloat titleImageDistance;    

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

@property (nonatomic, assign) CGFloat imageBordeWidth;
@property (nonatomic, strong) UIColor * imageBordeColor;

@end
