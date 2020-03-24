//
//  InfoPickerView.h
//  QiPao
//
//  Created by 李明洋 on 2017/9/15.
//  Copyright © 2017年 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfoPickerView;

@protocol infoPickerDelegate <NSObject>

-(void)pickerView:(InfoPickerView *)pickerView Select:(NSString *)object withIndex:(NSInteger)index;

@end

@interface InfoPickerView : UIView

/** 待选择的数组 */
@property (strong, nonatomic) NSArray *chooseArray;

@property (strong, nonatomic) NSString *title;

@property (weak, nonatomic) id<infoPickerDelegate> delegate;

/**  */
//@property (strong, nonatomic) NSArray *moreArray;

-(void)showInSuperView:(UIView *)superView;

@end
