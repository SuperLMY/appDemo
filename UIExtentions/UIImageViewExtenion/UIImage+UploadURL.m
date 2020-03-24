//
//  UIImage+UploadURL.m
//  CarDetection
//
//  Created by 李明洋 on 2019/4/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "UIImage+UploadURL.h"
#import <objc/runtime.h>

@implementation UIImage (UploadURL)

-(void)setImageUrl:(NSString *)imageUrl{
    if (imageUrl.length > 0) {
        objc_setAssociatedObject(self, @selector(imageUrl), imageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(NSString *)imageUrl{
    NSString *value = objc_getAssociatedObject(self, @selector(imageUrl));
    return value;
}

@end
