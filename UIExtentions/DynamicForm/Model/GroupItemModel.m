//
//  GourpItemModel.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "GroupItemModel.h"

@implementation GroupItems

-(void)setType:(NSString *)type{
    _type = type;
    if ([_type isEqualToString:@"text"]) {
        _selectType = GroupItemSelectTypeText;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"date"]){
        _selectType = GroupItemSelectTypeDate;
        _cellIdentifier = @"DateSelectTableViewCell";
    }else if ([_type isEqualToString:@"select"]){
        _selectType = GroupItemSelectTypeSelect;
        _cellIdentifier = @"SigleSelectTableViewCell";
    }else if ([_type isEqualToString:@"photo"]){
        _selectType = GroupItemSelectTypePhoto;
        _cellIdentifier = @"photoTableViewCell";
    }else if ([_type isEqualToString:@"image"]){
        _selectType = GroupItemSelectTypeSignleImage;
        _cellIdentifier = @"ImageViewTableViewCell";
    }else if ([_type isEqualToString:@"number"]){
        _selectType = GroupItemSelectTypeNumber;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"phoneNumber"]){
        _selectType = GroupItemSelectTypePhoneNumber;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"legalText"]){
        _selectType = GroupItemSelectTypeLegalText;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"plateText"]){
        _selectType = GroupItemSelectTypePlateText;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"ACapitalText"]){
        _selectType = GroupItemSelectTypeACapitalText;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"VINCapitalText"]){
        _selectType = GroupItemSelectTypeVINCapitalText;
        _cellIdentifier = @"TextFeildTableViewCell";
    }else if ([_type isEqualToString:@"special"]){
        _selectType = GroupItemSelectTypeSpecial;
    }else if ([_type isEqualToString:@"switch"]){
        _selectType = GroupItemSelectTypeSwitch;
    }else{
        _selectType = GroupItemSelectTypeNormal;
        _cellIdentifier = @"NormalTableViewCell";
    }
}

@end

@implementation GroupModel

@end
