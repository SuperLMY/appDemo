//
//  DebugLogTableCell.h
//  building
//
//  Created by 李明洋 on 2018/6/6.
//  Copyright © 2018年 datalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebugLogTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
