//
//  UIButton+Transform.h
//  building
//
//  Created by 李明洋 on 2018/5/4.
//  Copyright © 2018年 datalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonTransform : UIButton

/** 0.默认状态  1.上图片下文字居中对齐 2.左文字右图片居中对齐 */
@property (nonatomic) NSInteger type;
//-(void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
-(void)rightImageLayout;
-(void)topImageLayout;

@end
