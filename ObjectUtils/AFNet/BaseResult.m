//
//  BaseResult.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "BaseResult.h"

@implementation BaseResult

-(void)setCode:(NSString *)code{
    _code = code;
    if ([_code isEqualToString:@"000000"]) {
        _BaseCode = BaseResultCodeSuccess;
    }else if([_code isEqualToString:@"400"]){
        _BaseCode = BaseResultCodeFormatError;
    }else if([_code isEqualToString:@"401"]){
        _BaseCode = BaseResultCodePastToken;
    }else if([_code isEqualToString:@"403"]){
        _BaseCode = BaseResultCodePastToken;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:JZWPastToken object:nil];
        });
    }else if([_code isEqualToString:@"404"]){
        _BaseCode = BaseResultCode404NotFound;
    }else if([_code isEqualToString:@"500"]){
        _BaseCode = BaseResultCodeServiceError;
    }else{
        _BaseCode = BaseResultCodeUnkown;
    }
}

@end

@implementation BasePageResult

@end
