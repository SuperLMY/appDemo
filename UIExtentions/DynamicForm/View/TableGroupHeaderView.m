//
//  TableGroupHeaderView.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "TableGroupHeaderView.h"

@interface TableGroupHeaderView()

@property (strong, nonatomic) UIView *line;

@end

@implementation TableGroupHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backView;
}

-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.backgroundColor = RGB(26, 91, 173);
        _iconView.translatesAutoresizingMaskIntoConstraints = NO;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 2.5;
    }
    return _iconView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _line;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    [self addSubview:self.backView];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];
    
    // H 水平方向上
    NSArray *backConstsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"backView":self.backView}];
    // V 垂直方向
    NSArray *backConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"backView":self.backView}];
    [self addConstraints:backConstsH];
    [self addConstraints:backConstsV];
    
    // H 水平方向上
    NSArray *lineConstsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[line]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"line":self.line}];
    // V 垂直方向
    NSArray *lineConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[line(0.1)]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"line":self.line}];
    [self addConstraints:lineConstsH];
    [self addConstraints:lineConstsV];
    // H 水平方向上
    NSArray *consts1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[iconView(5)]-5-[titleLabel]-20-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"iconView":self.iconView,@"titleLabel":self.titleLabel}];
    NSArray *consts2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconView(15)]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"iconView":self.iconView}];
    // V 垂直方向上
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:_iconView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:consts1];
    [self addConstraints:consts2];
    [self addConstraint:constraint2];
    [self addConstraint:constraint3];
    
    return self;
}

@end
