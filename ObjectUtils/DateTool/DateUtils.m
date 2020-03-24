//
//  DateUtils.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/11.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

//-(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap{
//    NSTimeInterval timeInterval=[timeStamap doubleValue];
//    //  /1000;传入的时间戳timeStamap如果是精确到毫秒的记得要/1000
//    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
//    return UTCDate;
//}

@end

@implementation NSDate (TimeStampUtil)

+(NSDate *)UTCDateFromTimeStamap:(long)timeStamap{
    NSTimeInterval timeInterval = timeStamap;
    //  /1000;传入的时间戳timeStamap如果是精确到毫秒的记得要/1000
    NSDate *UTCDate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    return UTCDate;
}

+(NSString *)DateStringFromTimeStamap:(long)timeStamap{
    return [self DateStringDateFormat:@"yyyy年MM月dd日" FromTimeStamap:timeStamap];
}

+(NSString *)DateStringDateFormat:(NSString *)DateFormat FromTimeStamap:(long)timeStamap{
    NSDate *date = [self UTCDateFromTimeStamap:timeStamap];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:DateFormat];
    NSString *str = [formatter stringFromDate:date];//打印20
    return str;

}

+(long)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    return [datenow timeIntervalSince1970]*1000;
}

//+(NSString *)countdownFromTimeStamap:(long)timeStamap{
//    long seconds = lroundf(timeStamap); // Modulo (%) operator below needs int or long
//    int hour = seconds / 3600;
//    int mins = (seconds % 3600) / 60;
//    int secs = seconds % 60;
//    return [NSString stringWithFormat:@"%d时%d分%d秒",hour,mins,secs];
//}

+(NSString *)countdownFromTimeStamap:(long)timeStamap{
    long seconds = lroundf(timeStamap); // Modulo (%) operator below needs int or long
    int day = seconds / (3600*24);
    int hour = (seconds % (3600*24)) / 3600;
    return [NSString stringWithFormat:@"%d天%d时",day,hour];
}

@end
