//
//  GourpItemModel.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/8.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GroupItemSelectBlock)(NSString *string);

typedef NS_ENUM(NSInteger, GroupItemSelectType) {
    GroupItemSelectTypeNormal = 0,
    GroupItemSelectTypeSelect,
    GroupItemSelectTypeDate,
    GroupItemSelectTypeText,
    GroupItemSelectTypeNumber,
    GroupItemSelectTypePhoneNumber,
    GroupItemSelectTypeLegalText,
    GroupItemSelectTypePlateText,
    GroupItemSelectTypeVINCapitalText,
    GroupItemSelectTypeACapitalText,
    GroupItemSelectTypePhoto,
    GroupItemSelectTypeSignleImage,
    GroupItemSelectTypeSwitch,
    GroupItemSelectTypeSpecial,
};

@interface GroupItems : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) id moreObject;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *cellIdentifier;
@property (assign, nonatomic) GroupItemSelectType selectType;
@property (copy, nonatomic) GroupItemSelectBlock selectBlock;

@end

@interface GroupModel : NSObject

@property (strong, nonatomic) NSArray *GroupItems;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
