//
//  TableGroupHeaderView.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableGroupHeaderImageView : UITableViewHeaderFooterView

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

NS_ASSUME_NONNULL_END
