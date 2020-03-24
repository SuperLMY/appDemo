//
//  ColorViewToImage.m
//  TestDemo
//
//  Created by limingyang on 2020/3/6.
//  Copyright © 2020 limingyang. All rights reserved.
//

#import "ColorViewToImage.h"

@implementation ColorViewToImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(UIImage *)imageLineByColors:(NSArray *)colors{
    return [self imageLineByColors:colors size:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+44)];
}

+(UIImage *)imageLineByColors:(NSArray *)colors size:(CGSize)size{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (colors.count == 0) {
        return nil;
    }
    CAGradientLayer *gradientlayer = [CAGradientLayer layer];
    gradientlayer.colors = colors;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< colors.count; i++) {
        float s = 1.0/colors.count * (i+1);
        [array addObject:@(s)];
    }
    gradientlayer.locations = array;
    gradientlayer.startPoint = CGPointMake(0, 1);
    gradientlayer.endPoint = CGPointMake(1, 1);
    gradientlayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, gradientlayer.contentsScale);
    [gradientlayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

+(CALayer *)ColorLayerByColors:(NSArray *)colors{
    return [self ColorLayerByColors:colors size:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+44)];
}

+(CALayer *)ColorLayerByColors:(NSArray *)colors size:(CGSize)size{
    if (colors.count == 0) {
        return nil;
    }
    CAGradientLayer *gradientlayer = [CAGradientLayer layer];
    gradientlayer.colors = colors;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i< colors.count; i++) {
        float s = 1.0/colors.count * (i+1);
        [array addObject:@(s)];
    }
    gradientlayer.locations = array;
    gradientlayer.startPoint = CGPointMake(0, 1);
    gradientlayer.endPoint = CGPointMake(1, 1);
    gradientlayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    return gradientlayer;
}

+(CALayer *)layerByImage:(UIImage *)image{
    return [self layerByImage:image size:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+44)];
}

+(CALayer *)layerByImage:(UIImage *)image size:(CGSize)size{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.contents = (__bridge id _Nullable)(image.CGImage);
    return layer;
}

@end
