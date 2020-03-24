//
//  UIImage+Transform.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/4.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Transform)

+ (UIImage *)addwaterImageView:(UIImageView *)waterImageView toSuperView:(UIImageView *)superView;

@end

@interface UIImageView (Transform)

-(UIImage *)getImageAfterTransform;

@end

NS_ASSUME_NONNULL_END
