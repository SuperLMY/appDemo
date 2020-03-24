//
//  SaveToLibary.h
//  CarDetection
//
//  Created by limingyang on 2019/6/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImagePickerController (SaveToLibary)

-(void)saveToLibary:(UIImage *)image;


+(void)saveImageToLibary:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
