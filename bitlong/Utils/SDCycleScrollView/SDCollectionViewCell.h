//
//  SDCollectionViewCell.h
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.

//




#import <UIKit/UIKit.h>

@interface SDCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) UIImageView *maskView;
@property (weak, nonatomic) UIImageView *imageView;
@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) NSTextAlignment titleLabelTextAlignment;

@property (nonatomic, assign) BOOL hasConfigured;

@property (nonatomic, assign) BOOL onlyDisplayText;

-(void)showCoverPic:(BOOL)show;
-(void)removeNotifcation;
@end
