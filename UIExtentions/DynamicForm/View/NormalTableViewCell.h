//
//  NormalTableViewCell.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "GroupSuperViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalTableViewCell : GroupSuperViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

NS_ASSUME_NONNULL_END
