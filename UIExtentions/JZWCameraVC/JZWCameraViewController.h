//
//  JZWCameraViewController.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/3.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZWCameraViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol JZWCameraViewDelegate <NSObject>

//- (void)JZWCameraViewController:(JZWCameraViewController *)picker didFinishPickingImage:(UIImage *)image;

- (void)JZWCameraViewController:(JZWCameraViewController *)picker didFinishPickingImage:(UIImage *)image WaterImage:(UIImage *)waterImage;

- (void)JZWCameraViewControllerDidCancel:(JZWCameraViewController *)picker;

@end

@interface JZWCameraViewController : UIViewController

@property (weak, nonatomic) id<JZWCameraViewDelegate> delegate;

@property (assign, nonatomic) BOOL needWater;
@property (assign, nonatomic) BOOL allowLibary;
@property (assign, nonatomic) BOOL saveToLibary;

@property (strong, nonatomic) UIImage *editImage;

@end

NS_ASSUME_NONNULL_END
