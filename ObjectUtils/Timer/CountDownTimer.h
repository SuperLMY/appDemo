//
//  CountDownTimer.h
//  JZWRetailer
//
//  Created by 李明洋 on 2019/4/30.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountDownTimer : NSObject

@property (weak, nonatomic) NSTimer *timer;

+(instancetype)shareTimer;

-(void)startCountDown;
-(void)stopCountDown;

@end

NS_ASSUME_NONNULL_END
