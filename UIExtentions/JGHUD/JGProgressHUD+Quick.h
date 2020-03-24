//
//  JGProgressHUD+Quick.h
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "JGProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGProgressHUD (Quick)

+(void)showLoading:(NSString *)message;

+(void)showSuccessHUD:(NSString *)message;

+(void)showSuccessHUDFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+(void)showErrorHUD:(NSString *)message;

+(void)showErrorHUDFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+(void)HidHUD;

@end

NS_ASSUME_NONNULL_END
