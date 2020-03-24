//
//  Object+SafeValue.m
//  SCbuilding
//
//  Created by 李明洋 on 2018/10/9.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import "Object+SafeValue.h"

@implementation NSObject (SafeValue)

NSString *SafeValue(id value) {
    if (!value) {
        return @"";
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"<null>"] || [value isEqualToString:@"null"] || [value isEqualToString:@"(null)"] || [value isEqualToString:@"nil"]) {
            return @"";
        }else {
            return value;
        }
    } else if([value isEqual:[NSNull null]]){
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@", value];
    }
}

NSString *SafeValue_0(id value) {
    if (!value) {
        return @"0";
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"<null>"] || [value isEqualToString:@"null"] || [value isEqualToString:@"(null)"] || [value isEqualToString:@"nil"]) {
            return @"0";
        }else {
            return value;
        }
    }else {
        return [NSString stringWithFormat:@"%@", value];
    }
}

NSString *SafeValue_Space(id value) {
    if (!value) {
        return @" ";
    } else if ([value isKindOfClass:[NSString class]]) {
        if ([value isEqualToString:@"<null>"] || [value isEqualToString:@"null"] || [value isEqualToString:@"(null)"] || [value isEqualToString:@"nil"]) {
            return @" ";
        }else {
            return value;
        }
    } else if([value isEqual:[NSNull null]]){
        return @" ";
    }else {
        return [NSString stringWithFormat:@"%@", value];
    }
}

@end

@implementation NSNull (Safe)

+(BOOL)boolValue{
    return NO;
}

-(BOOL)boolValue{
    return NO;
}

+(NSString *)stringValue{
    return @"";
}

-(NSString *)stringValue{
    return @"";
}

+(NSInteger)count{
    return 0;
}

-(NSInteger)count{
    return 0;
}

+(NSInteger)intValue{
    return 0;
}

-(NSInteger)intValue{
    return 0;
}

+(long)longLongValue{
    return 0;
}

-(long)longLongValue{
    return 0;
}

+(id)objectForKeyedSubscript:(id)key{
    return nil;
}

-(id)objectForKeyedSubscript:(id)key{
    return nil;
}

+(NSUInteger)length{
    return 0;
}

-(NSUInteger)length{
    return 0;
}


@end
