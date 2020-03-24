//
//  GroupSuperViewCell.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupSuperViewCell : UITableViewCell

@property (strong, nonatomic) GroupItems *model;

@property (assign, nonatomic) NSInteger row;
@property (assign, nonatomic) NSInteger section;

//-(void)setModel:(GroupItems *)item;

@end

NS_ASSUME_NONNULL_END
