//
//  MyTabBarViewController.m
//  TestDemo
//
//  Created by limingyang on 2020/3/12.
//  Copyright © 2020 limingyang. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "ChildViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[ChildViewController new]];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[ChildViewController new]];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:[ChildViewController new]];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:[ChildViewController new]];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:[ChildViewController new]];
    if (@available(iOS 13.0, *)) {
        [self addChildViewController:nav1 title:@"首页" imageNamed:[UIImage systemImageNamed:@"house"] SelectImage:[UIImage systemImageNamed:@"house.fill"]];
        [self addChildViewController:nav2 title:@"发现" imageNamed:[UIImage systemImageNamed:@"book"] SelectImage:[UIImage systemImageNamed:@"book.fill"]];
        [self addChildViewController:nav3 title:@"发现" imageNamed:[UIImage systemImageNamed:@"book"] SelectImage:[UIImage systemImageNamed:@"book.fill"]];
        [self addChildViewController:nav4 title:@"发现" imageNamed:[UIImage systemImageNamed:@"book"] SelectImage:[UIImage systemImageNamed:@"book.fill"]];
        [self addChildViewController:nav5 title:@"个人" imageNamed:[UIImage systemImageNamed:@"person"] SelectImage:[UIImage systemImageNamed:@"person.fill"]];
    } else {
        // Fallback on earlier versions
    }
    
    self.tabBar.tintColor = [UIColor blackColor];
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"car.png"];
}

- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(UIImage *)image SelectImage:(UIImage *)selectImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    [self addChildViewController:vc];
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
