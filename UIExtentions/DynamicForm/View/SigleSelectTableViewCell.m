//
//  SigleSelectTableViewCell.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "SigleSelectTableViewCell.h"

@implementation SigleSelectTableViewCell

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
    if (model.value.length > 0) {
        _selectLabel.text = model.value;
        _selectLabel.textColor = [UIColor blackColor];
    }else{
        _selectLabel.text = @"请选择";
        _selectLabel.textColor = [UIColor lightGrayColor];
    }
}

@end
