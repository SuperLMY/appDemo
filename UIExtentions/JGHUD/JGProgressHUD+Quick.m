//
//  JGProgressHUD+Quick.m
//  CarDetection
//
//  Created by 李明洋 on 2019/3/25.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "JGProgressHUD+Quick.h"

@implementation JGProgressHUD (Quick)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static JGProgressHUD *staticHUD;

+ (JGProgressHUD *)prototypeHUD {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        HUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
        JGProgressHUDFadeZoomAnimation *an = [JGProgressHUDFadeZoomAnimation animation];
        HUD.animation = an;
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
        HUD.vibrancyEnabled = YES;
        HUD.shadow = [JGProgressHUDShadow shadowWithColor:[UIColor blackColor] offset:CGSizeZero radius:5.0 opacity:0.3f];
        staticHUD = HUD;
    });
    return staticHUD;
}

+(void)showLoading:(NSString *)message{
    [self prototypeHUD];
    staticHUD.indicatorView = [[JGProgressHUDIndeterminateIndicatorView alloc] init];;
    staticHUD.textLabel.text = message;
    staticHUD.square = YES;
    staticHUD.layoutMargins = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [staticHUD showInView:[UIApplication sharedApplication].keyWindow];
}

+(void)showErrorHUD:(NSString *)message{
    [self prototypeHUD];
    staticHUD.textLabel.text = message;
    staticHUD.indicatorView = [[JGProgressHUDErrorIndicatorView alloc] init];
    staticHUD.square = message.length <= 8;
    [staticHUD showInView:[UIApplication sharedApplication].keyWindow];
    
    [staticHUD dismissAfterDelay:1.5];
}

+(void)showErrorHUDFormat:(NSString *)format, ...{
    va_list ap;
    va_start(ap, format);
    NSString *title = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
//    NSLog(@"%@",title);
    [self showErrorHUD:title];
}

+(void)showSuccessHUDFormat:(NSString *)format, ...{
    va_list ap;
    va_start(ap, format);
    NSString *title = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    [self showSuccessHUD:title];
}

+(void)showSuccessHUD:(NSString *)message{
    [self prototypeHUD];
    staticHUD.textLabel.text = message;
    staticHUD.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
    staticHUD.square = message.length <= 8;
    [staticHUD showInView:[UIApplication sharedApplication].keyWindow];
    
    [staticHUD dismissAfterDelay:1.5];
}

+(void)HidHUD{
    [staticHUD dismissAfterDelay:0.1];
}

@end
