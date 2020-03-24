//
//  BGlayerView.m
//  iCar
//
//  Created by 李明洋 on 2017/12/7.
//  Copyright © 2017年 Mobisit. All rights reserved.
//

#import "BGlayerView.h"

@implementation BGlayerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //self.backgroundColor = [UIColor clearColor];
    
    CGRect myRect = _colorframe;
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:myRect];
    //镂空
    //UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myRect];
    //[path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    if (_topColor) {
        fillLayer.fillColor = _topColor.CGColor;
    }else{
        fillLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    
    fillLayer.opacity = 0.5;
    [self.layer addSublayer:fillLayer];
}

@end
