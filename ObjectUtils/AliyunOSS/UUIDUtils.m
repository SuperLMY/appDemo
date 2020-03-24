//
//  UUIDUtils.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/2.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "UUIDUtils.h"
#import "DateUtils.h"

@implementation UUIDUtils

//+ (NSString *)createCUID:(NSString *)prefix
//{
//    NSString *result;
//    CFUUIDRef uuid;
//    CFStringRef uuidStr;
//    uuid = CFUUIDCreate(NULL);
//    uuidStr = CFUUIDCreateString(NULL, uuid);
////    result =[NSString stringWithFormat:@"%@-%@", prefix,uuidStr];
//    CFRelease(uuidStr);
//    CFRelease(uuid);
//
//    return result;
//}

+(NSString *)createCUID:(NSString *)prefix{
    long time = [NSDate getNowTimeTimestamp];
    
    return @(time).stringValue;
}

@end
