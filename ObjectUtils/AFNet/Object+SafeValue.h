//
//  Object+SafeValue.h
//  SCbuilding
//
//  Created by 李明洋 on 2018/10/9.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SafeValue)

/** 转化为空字符串 @"" */
extern NSString *SafeValue(id value);
/** 转化为 0 @"0" */
extern NSString *SafeValue_0(id value);
/** 转化为 0 @" " 空格占位 */
extern NSString *SafeValue_Space(id value);

@end

@interface NSNull (Safe)

+(BOOL)boolValue;

-(BOOL)boolValue;

+(NSString *)stringValue;

-(NSString *)stringValue;

+(NSInteger)count;

-(NSInteger)count;

+(NSInteger)intValue;

-(NSInteger)intValue;

+(long)longLongValue;

-(long)longLongValue;

+(id)objectForKeyedSubscript:(id)key;

-(id)objectForKeyedSubscript:(id)key;

+(NSUInteger)length;

-(NSUInteger)length;

@end

NS_ASSUME_NONNULL_END
