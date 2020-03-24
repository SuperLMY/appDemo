//
//  UITableView+dataLabel.h
//  Arithmetic
//
//  Created by 李明洋 on 2018/6/26.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (placeHold)

@property (nonatomic, strong) UIView *placeHolderView;

/** 允许默认样式hold */
-(void)allowDefaultHold:(BOOL)allow;

/** 允许hold 但需要手动设置holdView */
-(void)allowCenterHold:(BOOL)allow;

-(void)centerViewWithImage:(UIImage *)image frame:(CGRect)frame;

@end

@interface UITableView (TableViewHoldView)


@end

