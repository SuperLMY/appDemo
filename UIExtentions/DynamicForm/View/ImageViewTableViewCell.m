//
//  ImageViewTableViewCell.m
//  CarDetection
//
//  Created by limingyang on 2019/8/13.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "ImageViewTableViewCell.h"

@implementation ImageViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(GroupItems *)model{
    [super setModel:model];
//    _titleLabel.text = model.title;
    if ([model.moreObject isKindOfClass:[UIImage class]]) {
        _signleimageView.image = model.moreObject;
    }else if([model.moreObject isKindOfClass:[NSString class]]){
        [_signleimageView sd_setImageWithURL:[NSURL URLWithString:model.moreObject] placeholderImage:[UIImage imageNamed:@"ImageHolder"]];
    }else {
        _signleimageView.image = [UIImage imageNamed:@"请拍摄或上传行驶证"];
    }
}

@end
