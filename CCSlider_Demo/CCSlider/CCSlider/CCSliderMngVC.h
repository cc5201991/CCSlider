//
//  CCSliderMngVC.h
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSliderModel.h"
#import "CCSliderConfig.h"

@interface CCSliderMngVC : UIViewController

//! 初始化
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array;
//! 初始化，带上配置信息
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array config:(CCSliderConfig *)config;
//! 初始化，index表示当前显示第几个页面
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array config:(CCSliderConfig *)config selIndex:(NSInteger)index;

@end
