//
//  CCTabVC.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCTabVC.h"
#import "ViewController.h"
#import "CCSlider.h"

@interface CCTabVC ()



@end

@implementation CCTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    
    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    nav1.navigationBar.translucent = NO;
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"页面1" image:nil tag:0];
    
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < 6; i ++) {
        CCSliderModel * model = [CCSliderModel new];
        model.strTitle = [NSString stringWithFormat:@"页面 %d",i];
        model.strClassName = @"CCSubVC1";
        [array addObject:model];
    }
    
    CCSliderConfig * config = [CCSliderConfig new];
    config.titleHeight = 64;
    config.colorTitleBack = CC_HexColor(0x49a7f6);
    config.colorUpper = [UIColor whiteColor];
    config.colorLower = CC_HexColor(0xf5f5f5);
    
    CCSliderMngVC * vc = [[CCSliderMngVC alloc] initWithModels:array config:config selIndex:0];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav2 setNavigationBarHidden:YES];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"页面2" image:nil tag:0];
    
    self.viewControllers = @[nav1,nav2];
}



@end
