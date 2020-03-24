//
//  ColorViewToImage.h
//  TestDemo
//
//  Created by limingyang on 2020/3/6.
//  Copyright © 2020 limingyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorViewToImage : UIView

/** 获取渐变色图片对象 Colors <CGColor> */
+(UIImage *)imageLineByColors:(NSArray *)colors;
+(UIImage *)imageLineByColors:(NSArray *)colors size:(CGSize)size;
/** 获取渐变色图层 */
+(CALayer *)ColorLayerByColors:(NSArray *)colors size:(CGSize)size;
+(CALayer *)ColorLayerByColors:(NSArray *)colors;
/** 获取image渲染图层 */
+(CALayer *)layerByImage:(UIImage *)image size:(CGSize)size;
+(CALayer *)layerByImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
