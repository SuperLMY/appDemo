//
//  PopViewController.m
//  TestDemo
//
//  Created by limingyang on 2020/3/12.
//  Copyright © 2020 limingyang. All rights reserved.
//

#import "PopViewController.h"
#import "ChildViewController.h"
#import "SettingViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface PopViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *leftView;

@property (strong, nonatomic) UIView *mianView;

@property (assign, nonatomic) CGFloat startPoint;
 
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.navigationItem.title = @"仿版";
//    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStyleDone target:self.presentedViewController action:_back];
//    self.navigationItem.rightBarButtonItem = back;
    
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(-SCREEN_WIDTH+100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT)];
    _leftView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_leftView];
    
    _mianView = [[UIView alloc]initWithFrame:self.view.bounds];
    _mianView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mianView];
//
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    pan.delegate = self;
    [_mianView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_mianView addGestureRecognizer:tap];
    
    ChildViewController *vc = [ChildViewController new];
    vc.openLeft = @selector(openOrClose);
    vc.back = @selector(back);
    [self addChildViewController:vc];
    [_mianView addSubview:vc.view];
    
    SettingViewController *svc = [SettingViewController new];
    [self addChildViewController:svc];
    [_leftView addSubview:svc.view];
}

-(void)openOrClose{
    if (_mianView.frame.origin.x == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.mianView.frame = CGRectMake(SCREEN_WIDTH-100, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            self.leftView.frame = CGRectMake(0, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
        }];
    }else{
        [self tapAction];
    }
}

-(void)back{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)tapAction{
    [UIView animateWithDuration:0.2 animations:^{
        self.mianView.frame = self.view.bounds;
        self.leftView.frame = CGRectMake(-SCREEN_WIDTH+100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
    }];
}

-(void)panAction:(UIPanGestureRecognizer *)pan{
    CGPoint panGesturePoint = [pan translationInView:self.mianView];
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    }
    if(pan.state == UIGestureRecognizerStateChanged){
        CGRect frame = _mianView.frame;
        frame.origin.x = frame.origin.x + panGesturePoint.x;
        if (frame.origin.x <= 0) {
            frame.origin.x = 0;
        }
        if (frame.origin.x >= SCREEN_WIDTH-100) {
            frame.origin.x = SCREEN_WIDTH-100;
        }
        _mianView.frame = frame;
        CGRect leftframe = _leftView.frame;
        leftframe.origin.x = leftframe.origin.x + panGesturePoint.x;
        if (leftframe.origin.x >= 0) {
            leftframe.origin.x = 0;
        }
        _leftView.frame = leftframe;
        [pan setTranslation:CGPointZero inView:pan.view];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGRect frame = _mianView.frame;
        if (frame.origin.x <= (SCREEN_WIDTH-80)/2.0) {
            frame.origin.x = 0;
            [UIView animateWithDuration:0.2 animations:^{
                self.mianView.frame = frame;
                self.leftView.frame = CGRectMake(-SCREEN_WIDTH+100, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
            }];
        }else {
            frame.origin.x = SCREEN_WIDTH-100;
            [UIView animateWithDuration:0.2 animations:^{
                self.mianView.frame = frame;
                self.leftView.frame = CGRectMake(0, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT);
            }];
        }
    }
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    if (self.startPoint < 80) {
        return YES;
    }
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self.mianView].x;
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
