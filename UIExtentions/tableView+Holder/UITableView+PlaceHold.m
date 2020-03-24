//
//  UITableView+dataLabel.m
//  Arithmetic
//
//  Created by 李明洋 on 2018/6/26.
//  Copyright © 2018年 李明洋. All rights reserved.
//

#import "UITableView+PlaceHold.h"
#import <objc/runtime.h>

@implementation UITableView (placeHold)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static char kAllowCenterPlaceHold;

+(void)load{
    Method oldMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method newMethod = class_getInstanceMethod(self, @selector(ck_reloadData));
    method_exchangeImplementations(oldMethod, newMethod);
}

-(void)ck_reloadData{
    //NSLog(@"刷新");
    if ([self getAllowCenterHold]) {
        BOOL isEmpty = YES;
        id<UITableViewDataSource> src = self.dataSource;
        NSInteger sections = 1;
        if ([src respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [src numberOfSectionsInTableView:self];
        }
        for (int i = 0; i < sections; i++) {
            NSInteger rows = [src tableView:self numberOfRowsInSection:i];
            if (rows) {
                isEmpty = NO;
            }
        }
        if (isEmpty) {
            [self.placeHolderView removeFromSuperview];
            [self addSubview:self.placeHolderView];
        }else{
            [self.placeHolderView removeFromSuperview];
        }
    }
    [self ck_reloadData];
}

-(void)allowDefaultHold:(BOOL)allow{
    UILabel *hold = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, self.bounds.size.width, 60)];
    //hold.backgroundColor = [UIColor blueColor];
    hold.text = @"暂无数据";
    hold.textAlignment = NSTextAlignmentCenter;
    self.placeHolderView = hold;
    [self allowCenterHold:allow];
}

-(void)allowCenterHold:(BOOL)allow{
    objc_setAssociatedObject(self, &kAllowCenterPlaceHold, @(allow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)getAllowCenterHold{
    id hidden = objc_getAssociatedObject(self, &kAllowCenterPlaceHold);
    if (hidden) {
        return [hidden boolValue];
    }
    return NO;
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

-(void)centerViewWithImage:(UIImage *)image frame:(CGRect)frame{
    UIImageView *view = [[UIImageView alloc]initWithImage:image];
    view.frame = frame;
    view.contentMode = UIViewContentModeScaleAspectFit;
    [self setPlaceHolderView:view];
}

@end

@implementation UITableView (TableViewHoldView)

//-(UIView *)centerViewWithImage:(UIImage *)image size:(CGSize)size{
//    UIImageView *view = [[UIImageView alloc]initWithImage:image];
//    view.bounds = CGRectMake(0, 0, size.width, size.height);
//    view.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
//    view.contentMode = UIViewContentModeScaleAspectFit;
//    return view;
//}

@end
