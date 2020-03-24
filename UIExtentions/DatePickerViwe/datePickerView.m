//
//  datePickerView.m
//
//  Created by 李明洋 on 17/3/9.
//  Copyright © 2017年 李明洋. All rights reserved.
//

#import "datePickerView.h"

@interface datePickerView ()
{
    UIView *_backView;
    UIDatePicker *datePicker;       //日期选择
}

@property (assign, nonatomic) CGFloat iPhonex_b;

@end

@implementation datePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGFloat)iPhonex_b{
    if (@available(iOS 11.0, *) ) {
        _iPhonex_b = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }else{
        _iPhonex_b = 0;
    }
    return _iPhonex_b;
}

-(void)showInSuperView:(UIView *)superView{
    if (!superView) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    if (!superView) {
        superView = [UIApplication sharedApplication].windows.lastObject;
    }
    if (!superView) {
        superView = [UIApplication sharedApplication].windows.firstObject;
    }
    [self addBackView:superView];
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 220+self.iPhonex_b);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    [superView addSubview:self];
    
    UILabel *alertTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 80, 30)];
    alertTitle.center = CGPointMake(self.frame.size.width/2.0, alertTitle.center.y);
    alertTitle.text = @"选择日期";
    alertTitle.textAlignment = NSTextAlignmentCenter;
    alertTitle.font = Font(15);
    alertTitle.textColor = [UIColor darkGrayColor];
    [self addSubview:alertTitle];
    
    if (_otherItem) {
        UIButton *reBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 15, 70, 30)];
        [reBtn setTitle:_otherItem forState:UIControlStateNormal];
        [reBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
        [reBtn addTarget:self action:@selector(reBtnaction) forControlEvents:UIControlEventTouchUpInside];
        reBtn.titleLabel.font = Font(15);
        [self addSubview:reBtn];
    }
    
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 120)];
    datePicker.backgroundColor = [UIColor whiteColor];
    //datePicker.layer.cornerRadius = 20.0;
    //datePicker.layer.masksToBounds = YES;
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    if (_maxDate) {
        [datePicker setMaximumDate:[NSDate date]];
    }
    if (_minDate) {
        [datePicker setMinimumDate:[NSDate date]];
    }
    // 设置UIDatePicker的显示模式
    if (_timeMode) {
        [datePicker setDatePickerMode:UIDatePickerModeDate];
    }else{
        [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    }
    // 当值发生改变的时候调用的方法
    //[datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
    //
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, 175, SCREEN_WIDTH-60, 0.5)];
    line1.backgroundColor = [UIColor colorWithWhite:0.83 alpha:1];
    [self addSubview:line1];
    
//    UIButton *reBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 175, self.frame.size.width/2.0, 45)];
//    [reBtn setTitle:@"全部日期" forState:UIControlStateNormal];
//    [reBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [reBtn addTarget:self action:@selector(reBtnaction) forControlEvents:UIControlEventTouchUpInside];
//    reBtn.titleLabel.font = Font(15);
//    [self addSubview:reBtn];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 175, self.frame.size.width-20, 45)];
    //sureButton.backgroundColor = [UIColor whiteColor];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.titleLabel.font = Font(15);
    [sureButton setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(getBirTouchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    
//    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, 175, 0.5, 30)];
//    line2.center = CGPointMake(self.frame.size.width/2.0, sureButton.center.y);
//    line2.backgroundColor = [UIColor colorWithWhite:0.83 alpha:1];
//    [self addSubview:line2];
    
    [UIView animateWithDuration:0.15 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT-self.bounds.size.height, SCREEN_WIDTH, self.bounds.size.height);
    }];
}


-(void)reBtnaction{
    NSString *str = @"待确认";

    if(_delegate && [_delegate respondsToSelector:@selector(datePickerTime:HoldModel:)]){
        [_delegate datePickerTime:str HoldModel:_model];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(datePickerTime:date:)]){
        [_delegate datePickerTime:str date:datePicker.date];
    }
    [self closeView:nil];
}

//时间选择事件
-(void)getBirTouchAction:(UIButton *)sender
{
    NSDateFormatter *format3 = [[NSDateFormatter alloc]init];
    if (_timeMode) {
        [format3 setDateFormat:@"YYYY-MM-dd"];
    }else{
        [format3 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    
    NSString *str = [format3 stringFromDate:datePicker.date]; //UIDatePicker显示的时间
    NSLog(@"str  == %@",str);
    if(_delegate && [_delegate respondsToSelector:@selector(datePickerTime:HoldModel:)]){
        [_delegate datePickerTime:str HoldModel:_model];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(datePickerTime:date:)]){
        [_delegate datePickerTime:str date:datePicker.date];
    }
    [self closeView:nil];
}

#pragma mark - 添加背景视图
- (void) addBackView:(UIView *) superView
{
    _backView = [[UIView alloc] init];
    _backView.frame = superView.bounds;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView:)];
    [_backView addGestureRecognizer:tap];
    [superView addSubview:_backView];
    [UIView animateWithDuration:0.2 animations:^{
        _backView.alpha = 0.4;
    }];
}

-(void)closeView:(id)sender{
    [_backView removeFromSuperview];
    _backView = nil;
    [UIView animateWithDuration:0.25 animations:^{
        //self.alpha = 0.5;
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
