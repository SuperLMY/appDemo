//
//  UIImageView+.m
//  CarDetection
//
//  Created by limingyang on 2019/5/23.
//  Copyright © 2019 李明洋. All rights reserved.
//

#import "UIImageView+Upload.h"
#import <objc/runtime.h>

@implementation UIImageView (Upload)

-(void)setUploading:(BOOL)uploading{
    if (uploading) {
        if (!self.uploadView) {
            UIView *view = [self createUploadView];
            self.uploadView = view;
        }
        [self addSubview:self.uploadView];
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.uploadView viewWithTag:5];
        [indicatorView startAnimating];
    }else{
        if (self.uploadView) {
            UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self.uploadView viewWithTag:5];
            [indicatorView stopAnimating];
        }
        [self.uploadView removeFromSuperview];
    }
}

-(BOOL)uploading{
    return NO;
}

-(UIView *)createUploadView{
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.center = CGPointMake(self.frame.size.width/2.0, (self.frame.size.height-80)/2.0+20);
    indicatorView.bounds = CGRectMake(0, 0, 40, 40);
    indicatorView.tag = 5;
    indicatorView.color = [UIColor whiteColor];
    [view addSubview:indicatorView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2.0, self.frame.size.width, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"图片上传中";
    label.font = Font(13);
    [view addSubview:label];
    return view;
}

-(void)setUploadView:(UIView *)uploadView{
    objc_setAssociatedObject(self, @selector(uploadView), uploadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)uploadView {
    UIView *view = objc_getAssociatedObject(self, @selector(uploadView));
    return view;
}


@end
