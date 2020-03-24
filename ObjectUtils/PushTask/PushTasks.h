//
//  PushTasks.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushTasks : NSObject

@property (strong, nonatomic) NSString *messageType;
@property (strong, nonatomic) NSString *orderNo;

/** 0.询价， 1.订单 */
@property (assign, nonatomic) NSInteger taskType;
@property (assign, nonatomic) BOOL autoTask;

@property (copy, nonatomic) void (^taskBlock)(NSInteger type);

+(instancetype)shareTask;
+(void)PushUserInfo:(NSDictionary *)userInfo;

-(void)automaticReadTask:(void(^)(NSInteger type))Read;

@end

NS_ASSUME_NONNULL_END
