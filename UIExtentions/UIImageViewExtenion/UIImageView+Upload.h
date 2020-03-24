//
//  UIImageView+.h
//  CarDetection
//
//  Created by limingyang on 2019/5/23.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Upload)

@property (assign, nonatomic) BOOL uploading;
@property (strong, nonatomic) UIView *uploadView;

@end

NS_ASSUME_NONNULL_END
