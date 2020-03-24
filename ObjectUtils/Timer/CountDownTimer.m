//
//  CountDownTimer.m
//  JZWRetailer
//
//  Created by 李明洋 on 2019/4/30.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "CountDownTimer.h"

static CountDownTimer *CDTimer;

@implementation CountDownTimer

+(instancetype)shareTimer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CDTimer = [[CountDownTimer alloc]init];
    });
    return CDTimer;
}

-(void)countDown{
    [[NSNotificationCenter defaultCenter] postNotificationName:KTIMECOUNTDOWN object:nil];
}

-(void)startCountDown{
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
    [_timer fireDate];
    [self countDown];
}

-(void)stopCountDown{
    [_timer invalidate];
    _timer = nil;
}

@end
