//
//  TableGroupFooterView.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "TableGroupFooterView.h"

@interface TableGroupFooterView ()

@property (strong, nonatomic) UIView *backView;

@end

@implementation TableGroupFooterView

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
        _backView.backgroundColor = BACKVIEW_COLOR;
        _backView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    [self addSubview:self.backView];
    // H 水平方向上
    NSArray *backConstsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"backView":self.backView}];
    // V 垂直方向
    NSArray *backConstsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backView]-0-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"backView":self.backView}];
    [self addConstraints:backConstsH];
    [self addConstraints:backConstsV];
    
    return self;
}

@end
