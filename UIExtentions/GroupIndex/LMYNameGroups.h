//
//  LMYNameGroups.h
//  shiyisheng
//
//  Created by 李明洋 on 17/3/6.
//  Copyright © 2017年 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMYNameGroups : NSObject

/**
 *  传入一个拼音的数组，按拼音首字母分组排序
 */
+(NSMutableDictionary *)groupByPINYIN:(NSArray *)PINYINArray;

/**
 *  传入一个中文的数组（可以是中英文混合数组），按拼音首字母分组排序
 */
+(NSMutableDictionary *)groupByCHINESE:(NSArray *)CHINESEArray;

/**
 *  传入一个字符数组，按A-Z排序
 */
+(NSArray *)groupByKeyArray:(NSArray *)KeyArray;

+(NSString *) pinyinFromChineseString:(NSString *)string;

@end
