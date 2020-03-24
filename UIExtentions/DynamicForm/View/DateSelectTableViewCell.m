//
//  DateSelectTableViewCell.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "DateSelectTableViewCell.h"

@implementation DateSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(GroupItems *)model{
    _titleLabel.text = model.title;
    _selectLabel.text = model.value;
}

@end
