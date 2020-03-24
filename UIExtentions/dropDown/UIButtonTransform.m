//
//  UIButton+Transform.m
//  building
//
//  Created by 李明洋 on 2018/5/4.
//  Copyright © 2018年 datalk. All rights reserved.
//

#import "UIButtonTransform.h"

@implementation UIButtonTransform : UIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)rightImageLayout{
    _type = 2;
}

-(void)topImageLayout{
    _type = 1;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_type == 2) {
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.bounds.size.width, 0, self.imageView.bounds.size.width)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width+5, 0, -self.titleLabel.bounds.size.width)];
    }else if (_type == 1){
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
        CGFloat totalHeight = (imageSize.height + titleSize.height + 6);
        self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    }
}



@end
