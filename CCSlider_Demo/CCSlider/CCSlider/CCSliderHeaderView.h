//
//  CCSliderHeaderView.h
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSliderConfig.h"

@class CCSliderHeaderView;

@protocol CCSliderHeaderViewDelegate <NSObject>

@optional

//! 点击了某个按钮(只在点击的时候才触发delegate)
- (void)header:(CCSliderHeaderView *)headerView didSelectItemAtIndex:(NSInteger)index;

@end

@interface CCSliderHeaderView : UIView

@property (nonatomic, weak)     id<CCSliderHeaderViewDelegate> delegate;
//! 上层的前景色，默认为RGBA(0.1, 0.3, 0.9, 1.0)
@property (nonatomic, strong)   UIColor * colorUpper;
//! 下层的前景色，默认为RGBA(0.1, 0.3, 0.9, 0.7)
@property (nonatomic, strong)   UIColor * colorLower;
//! 上层的线条
@property (nonatomic, strong, readonly)     UIView * vLineUpper;
//! 下层的线条
@property (nonatomic, strong, readonly)     UIView * vLineLower;

//! header中所有的title
@property (nonatomic, strong, readonly)     NSMutableArray * arrTitles;

//! 配置信息
@property (nonatomic, strong)   CCSliderConfig * cc_config;


//! 初始化，带上配置信息
- (instancetype)initWithFrame:(CGRect)frame andConfig:(CCSliderConfig *)config;

//! 将headerView中的按钮置为titles。当按钮数量不多时，此方法会平均分配每个按钮的宽度，直至占满屏幕
- (void)setTitles:(NSArray *)titles;
//! 向headerView中添加多个按钮
- (void)addTitles:(NSArray *)titles;
//! 向headerView中添加一个按钮，按钮文字内容为title
- (void)addTitle:(NSString *)title;


//! 清空所有title
- (void)clear;

//! 选中某个button
- (void)selectButtonAtIndex:(NSInteger)index;

//! 滑动进度（从第0个section向第1个section滑动时，进度为0-1之间，从第5个向第4个滑动时，进度为4-5之间）
- (void)scrollWithProgress:(float)progress;


@end
