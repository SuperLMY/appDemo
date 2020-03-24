//
//  Json.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/1.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Json) 

/**
 *  转换成JSON串字符串（没有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toJSONString;

/**
 *  转换成JSON串字符串（有可读性）
 *
 *  @return JSON字符串
 */
- (NSString *)toReadableJSONString;

/**
 *  转换成JSON数据
 *
 *  @return JSON数据
 */
- (NSData *)toJSONData;


+ (id)ArrayByJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
