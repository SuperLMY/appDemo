//
//  TextFeildTableViewCell.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "GroupSuperViewCell.h"


NS_ASSUME_NONNULL_BEGIN
@protocol TextFeildCellDelegate <NSObject>

@optional
-(void)TextFeildCellSection:(NSInteger)section row:(NSInteger)index text:(NSString *)string;

@end

@interface TextFeildTableViewCell : GroupSuperViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;

@property (weak, nonatomic) id<TextFeildCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
