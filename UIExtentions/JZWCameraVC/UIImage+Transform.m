//
//  UIImage+Transform.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/4.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "UIImage+Transform.h"

@implementation UIImage (Transform)

+(UIImage *)addwaterImageView:(UIImageView *)waterImageView toSuperView:(UIImageView *)superView{
    UIGraphicsBeginImageContextWithOptions(superView.image.size, NO, 1);
    // 原始图片渲染
    [superView.image drawInRect:CGRectMake(0, 0, superView.image.size.width, superView.image.size.height)];
    // 打入的水印图片 渲染
    UIImage *wimage = [waterImageView getImageAfterTransform];
    //变化后尺寸
    CGAffineTransform trans = waterImageView.transform;
    CGFloat scale = sqrt(trans.a*trans.a + trans.c*trans.c);
    CGRect rect = waterImageView.bounds;
    //旋转
    CGFloat rotate = atanf(trans.b/trans.a);
    if (trans.a < 0 && trans.b > 0) {
        rotate += M_PI;
        
    }else if(trans.a <0 && trans.b < 0){
        rotate -= M_PI;
    }
    CGRect afterRect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(rotate));         // 水印变化后的尺寸 位置
//    CGFloat widthKey = afterRect.size.width*scale/SCREEN_WIDTH;
//    CGFloat sw = widthKey*superView.image.size.width;
//    CGFloat heightKey = afterRect.size.height*scale/SCREEN_HEIGHT;
//    CGFloat sh = heightKey*superView.image.size.height;
//    //变化后坐标
//    CGFloat originxKey = waterImageView.frame.origin.x/SCREEN_WIDTH;
//    CGFloat ox = originxKey*superView.image.size.width;
//
////    CGFloat height = superView.image.size.
//    CGFloat centeryKey = waterImageView.frame.origin.y/SCREEN_HEIGHT;
//    CGFloat oy = centeryKey*(superView.image.size.height);

    UIImage *superImage = superView.image;
    // 相对宽度
    CGFloat widthKey = afterRect.size.width*scale/SCREEN_WIDTH;
    CGFloat sw = widthKey*superView.image.size.width;
    // 相对高度
    CGFloat photoH = SCREEN_WIDTH*superImage.size.height/superImage.size.width;
    CGFloat heightKey = afterRect.size.height*scale/photoH;
    CGFloat sh = heightKey*superView.image.size.height;
    //变化后坐标 x
    CGFloat originXKey = waterImageView.frame.origin.x/SCREEN_WIDTH;
    CGFloat ox = originXKey*superView.image.size.width;
    //变化后坐标 y
    CGFloat GK_space = (SCREEN_HEIGHT-photoH)/2.0;
    CGFloat centerYKey = (waterImageView.frame.origin.y-GK_space)/photoH;
    CGFloat oy = centerYKey*(superImage.size.height);
    
    [wimage drawInRect:CGRectMake(ox, oy, sw, sh)];
    
    // UIImage
    UIImage * imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageNew;
}


@end

@implementation UIImageView (Transform)


-(UIImage *)getImageAfterTransform{
    CGAffineTransform _trans = self.transform;
    CGFloat rotate = atanf(_trans.b/_trans.a); //acosf(_trans.a);
    if (_trans.a < 0 && _trans.b > 0) {
        rotate += M_PI;
    }else if(_trans.a <0 && _trans.b < 0){
        rotate -= M_PI;
    }
    UIImage *tag =  [self rotateImageWithAngle:self.image radian:rotate IsExpand:YES];
    return tag;
}
// 弧度
- (UIImage*)rotateImageWithAngle:(UIImage*)vImg radian:(CGFloat)radian IsExpand:(BOOL)vIsExpand
{
    CGSize imgSize = CGSizeMake(vImg.size.width * vImg.scale, vImg.size.height * vImg.scale);
    
    CGSize outputSize = imgSize;
    if (vIsExpand) {
        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
        //旋转
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(radian));
        //NSLog(@"rotateImageWithAngle, size0:%f, size1:%f", imgSize.width, rect.size.width);
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, radian);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [vImg drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
// 角度
- (UIImage*)rotateImageWithAngle:(UIImage*)vImg Angle:(CGFloat)vAngle IsExpand:(BOOL)vIsExpand
{
    CGSize imgSize = CGSizeMake(vImg.size.width * vImg.scale, vImg.size.height * vImg.scale);
    
    CGSize outputSize = imgSize;
    if (vIsExpand) {
        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
        //旋转
        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(vAngle*M_PI/180.0));
        
        //NSLog(@"rotateImageWithAngle, size0:%f, size1:%f", imgSize.width, rect.size.width);
        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, vAngle*M_PI/180.0);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [vImg drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
