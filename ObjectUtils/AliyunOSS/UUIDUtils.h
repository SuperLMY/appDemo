//
//  UUIDUtils.h
//  CarDetection
//
//  Created by 李明洋 on 2019/4/2.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UUIDUtils : NSObject

+ (NSString *)createCUID:(NSString *)prefix;

@end

NS_ASSUME_NONNULL_END
