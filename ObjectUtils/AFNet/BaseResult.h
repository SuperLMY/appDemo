//
//  BaseResult.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BaseResultCodes){
    BaseResultCodeFormatError,
    BaseResultCodeServiceError,
    BaseResultCode404NotFound,
    BaseResultCodePastToken,
    BaseResultCodeSuccess,
    BaseResultCodeUnkown = 0,
};

@interface BaseResult : NSObject

@property (strong, nonatomic) NSString *code;
@property (assign, nonatomic) BaseResultCodes BaseCode;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSObject *data;

@end

@interface BasePageResult : BaseResult

@property (assign, nonatomic) long pageNum;
@property (assign, nonatomic) long pageSize;
@property (assign, nonatomic) long totalCount;
@property (assign, nonatomic) long totalPage;

@end

NS_ASSUME_NONNULL_END
