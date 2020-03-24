//
//  addCustomerViewController.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/7.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "BaseViewController.h"
#import "GroupItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseFormViewController : BaseViewController

@property (strong, nonatomic) UIButton *bottomBtn;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *groupItem;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
