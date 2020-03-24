//
//  SaveToLibary.m
//  CarDetection
//
//  Created by limingyang on 2019/6/28.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "UIImagePickerController+Save.h"


@implementation UIImagePickerController (SaveToLibary)


-(void)saveToLibary:(UIImage *)image{
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera && APPProduction.integerValue > 1) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}

+(void)saveImageToLibary:(UIImage *)image{
    if (image && APPProduction.integerValue > 1) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
