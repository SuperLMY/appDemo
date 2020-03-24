//
//  PictureCycleScrollView.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/11.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureCycleScrollView : UIView

@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) UILabel *titleLabel;

@property (copy, nonatomic) void(^selectIndex)(int index);

@end

NS_ASSUME_NONNULL_END
