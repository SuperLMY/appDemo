//
//  ImageMemary.h
//  CarDetection
//
//  Created by limingyang on 2019/7/1.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageMemary : NSObject

@property (strong, nonatomic, nullable) UIImage *image;
@property (strong, nonatomic, nullable) UIImage *waterImage;

@property (strong, nonatomic, nullable) NSString *imageUrl;
@property (strong, nonatomic, nullable) NSString *waterImageUrl;

-(instancetype)initWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
