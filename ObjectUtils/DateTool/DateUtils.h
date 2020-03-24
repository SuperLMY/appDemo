//
//  DateUtils.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/11.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtils : NSObject

//-(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap;

@end

@interface NSDate (TimeStampUtil)

+(NSDate *)UTCDateFromTimeStamap:(long)timeStamap;
+(NSString *)DateStringFromTimeStamap:(long)timeStamap;
+(NSString *)DateStringDateFormat:(NSString *)DateFormat FromTimeStamap:(long)timeStamap;
+(NSString *)countdownFromTimeStamap:(long)timeStamap;
+(long)getNowTimeTimestamp;

@end

NS_ASSUME_NONNULL_END
