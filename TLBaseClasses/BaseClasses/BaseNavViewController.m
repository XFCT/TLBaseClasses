//
//  BaseNavViewController.m
//  TLBaseClasses
//
//  Created by TL on 2018/3/20.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()<UIGestureRecognizerDelegate>
@end

@implementation BaseNavViewController

+ (void)initialize
{
    UIImage *bg = [UIImage imageNamed:@"navigationbarBackgroundRed"];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:bg forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes: @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.translucent = NO ;
    self.interactivePopGestureRecognizer.delegate = (id)self;
}
#pragma mark - 侧滑手势

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [button setImage:[UIImage imageNamed:@"nav_back_icon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.tabBarController.tabBar setHidden:YES];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

@end
