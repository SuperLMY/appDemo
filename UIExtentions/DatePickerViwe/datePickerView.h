//
//  datePickerView.h
//
//  Created by 李明洋 on 17/3/9.
//  Copyright © 2017年 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol datePickerViewDelegate <NSObject>

@optional
-(void)datePickerTime:(NSString *)timeString HoldModel:(id)model;
@optional
-(void)datePickerTime:(NSString *)timeString date:(NSDate *)date;

@end

@interface datePickerView : UIView

-(void)showInSuperView:(UIView *)superView;
@property (weak , nonatomic) id<datePickerViewDelegate> delegate;
@property (strong, nonatomic) NSString *timeMode;
@property (strong, nonatomic) NSString *otherItem;

@property (strong, nonatomic) id model;

@property (assign, nonatomic) BOOL maxDate;
@property (assign, nonatomic) BOOL minDate;

@end
