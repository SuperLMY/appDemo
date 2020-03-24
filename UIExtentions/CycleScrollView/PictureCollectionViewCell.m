//
//  PictureCollectionViewCell.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/11.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    _imageView = [UIImageView new];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
