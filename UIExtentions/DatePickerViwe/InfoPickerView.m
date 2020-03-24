//
//  InfoPickerView.m
//  QiPao
//
//  Created by 李明洋 on 2017/9/15.
//  Copyright © 2017年 李明洋. All rights reserved.
//

#import "InfoPickerView.h"

@interface InfoPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    //
    CGFloat sWeith;
    CGFloat sHeight;
    //
    UIView *backView;
    UIPickerView *cPickerView;
    //
    NSString *selectObject;
    NSInteger index;
}
@end

@implementation InfoPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
    sWeith = superView.frame.size.width;
    sHeight = superView.frame.size.height;
    
    backView = [[UIView alloc]initWithFrame:superView.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [superView addSubview:backView];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAction:)];
    [backView addGestureRecognizer:gesture];
    CGFloat _safeBottom = 0;
    if (@available(iOS 11.0, *) ) {
        _safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
    }else{
        _safeBottom = 0;
    }
    self.frame = CGRectMake(0, sHeight, sWeith, 300+_safeBottom);
    self.backgroundColor = [UIColor whiteColor];
    [superView addSubview:self];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, sWeith, 50)];
    titleLabel.text = @"请选择";
    if (_title) {
        titleLabel.text = _title;
    }
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, 50, sWeith-60, 0.4)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line1];
    
    cPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, sWeith, 200)];
    cPickerView.delegate = self;
    cPickerView.dataSource = self;
    [self addSubview:cPickerView];
    
    UIView *selectLine = [[UIView alloc]initWithFrame:CGRectMake(30, 113, sWeith-60, 0.4)];
    selectLine.backgroundColor = [UIColor darkGrayColor];
    [cPickerView addSubview:selectLine];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, 250, sWeith-60, 0.4)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line2];
    
    UIButton *makeSure = [[UIButton alloc]initWithFrame:CGRectMake(0, 250, sWeith, 50)];
    [makeSure setTitle:@"确 定" forState:UIControlStateNormal];
    [makeSure setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    makeSure.titleLabel.font = [UIFont systemFontOfSize:15];
    [makeSure addTarget:self action:@selector(makeSureAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeSure];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, sHeight - self.frame.size.height, sWeith, self.frame.size.height);
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _chooseArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_chooseArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    index = row;
    
    selectObject = [_chooseArray objectAtIndex:row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        //[pickerLabel setTextAlignment:NSTextAlignmentLeft];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}

-(void)closeAction:(id)sender{
    [UIView animateWithDuration:0.3 animations:^{
        backView.alpha = 0.1;
        self.frame = CGRectMake(0, sHeight, sWeith, self.frame.size.height);
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)makeSureAction:(id)sender{
    if (_chooseArray.count > 0) {
        if (index == 0) {
            selectObject = [_chooseArray objectAtIndex:0];
        }
        [_delegate pickerView:self Select:selectObject withIndex:index];
    }
    [self closeAction:nil];
}

@end
