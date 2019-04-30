//
//  BaseTabbarController.m
//  TLBaseClasses
//
//  Created by TL on 2018/3/20.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "BaseTabbarController.h"
#import "BaseNavViewController.h"

@interface BaseTabbarController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabbarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundColor:[UIColor grayColor]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self ;
    // 添加子控制器
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIImage *image1 = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage1 = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image1 ;
    vc.tabBarItem.selectedImage =selectedImage1;
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // 选中tabbaritem  do something 
    return YES;
}

@end
