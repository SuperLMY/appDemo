//
//  SigleSelectTableViewCell.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "GroupSuperViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SigleSelectTableViewCell : GroupSuperViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@end

NS_ASSUME_NONNULL_END
