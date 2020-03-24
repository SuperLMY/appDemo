//
//  EffectSelectView.h
//  iCar
//
//  Created by 李明洋 on 2017/12/6.
//  Copyright © 2017年 Mobisit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EffectSelectView;

typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeFromTop,
    AnimationTypeFromBottom,
    AnimationTypeFromLeft,
    AnimationTypeFromRight,
};

typedef NS_ENUM(NSInteger, SelectCellStyle) {
    SelectCellStyleNull,
    SelectCellStyleCheck,
    SelectCellStyleBackColor,
    SelectCellStyleTextColor,
};

@protocol EffectSelectViewDelegate <NSObject>

@optional
-(void)EffectViewReSet:(EffectSelectView *)effectView;

@optional
-(void)EffectViewCancel:(EffectSelectView *)effectView;

-(void)EffectSelectView:(EffectSelectView *)effectView didSelect:(id)object index:(NSInteger)index;

-(NSString *)EffectSelectView:(EffectSelectView *)effectView parsing:(id)model;

@end

@interface EffectSelectView : UIView

@property (weak, nonatomic) id<EffectSelectViewDelegate> delegate;

@property (strong, nonatomic) NSArray *array;
// 未开放其他动画
@property (nonatomic) AnimationType moveType;           //动画方向  默认自上而下

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) BOOL showReSet;

@property (nonatomic) SelectCellStyle selectStyle;

@property (nonatomic, strong) UIColor  *selectColor;

@property (nonatomic, assign) NSInteger selectIndex;

-(void)showInSuperView:(UIView *)superView;

@end
