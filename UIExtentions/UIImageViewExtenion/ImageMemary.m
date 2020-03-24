//
//  ImageMemary.m
//  CarDetection
//
//  Created by limingyang on 2019/7/1.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "ImageMemary.h"

@implementation ImageMemary

-(instancetype)initWithImage:(UIImage *)image{
    self = [super init];
    
    self.image = image;
    
    return self;
}

@end
