//
//  PushTasks.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "PushTasks.h"

static PushTasks *readTask;

@implementation PushTasks

+(instancetype)shareTask{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        readTask = [[PushTasks alloc]init];
    });
    return readTask;
}

+(void)PushUserInfo:(NSDictionary *)userInfo{
    PushTasks *taskObj = [PushTasks lmy_modelWithDict:userInfo];
    PushTasks *task = [PushTasks shareTask];
    task.autoTask = YES;
    task.orderNo = taskObj.orderNo;
    if ([taskObj.messageType isEqualToString:@"PURCHASE_ORDER_CANCEL_MSG"]) {           // 订单被取消
        task.taskType = 1;
    }else if([taskObj.messageType isEqualToString:@"WAIT_TRANSACTION_MSG"]){           // 询价已结束
        task.taskType = 0;
    }else if ([taskObj.messageType isEqualToString:@"PURCHASE_ORDER_PAY_MSG"]){
        task.taskType = 1;
    }
    [task readTask];
}

-(void)readTask{
    if (self.autoTask && self.taskBlock) {
        self.taskBlock(self.taskType);
        self.autoTask = NO;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //清除角标
    }
}

-(void)automaticReadTask:(void (^)(NSInteger type))Read{
    _taskBlock = Read;
    [self readTask];
}

@end
