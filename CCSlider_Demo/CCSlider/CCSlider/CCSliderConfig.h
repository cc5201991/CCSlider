//
//  CCSliderConfig.h
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef CC_ScreenWidth
#define CC_ScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef CC_ScreenHeight
#define CC_ScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#endif

#ifndef CC_HexColor
#define CC_HexColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif



@interface CCSliderConfig : NSObject

//! 标题栏的高度，默认45
@property (nonatomic, assign)   CGFloat titleHeight;
//! 字体，默认17号
@property (nonatomic, strong)   UIFont * fontDefault;
//! 标题栏按钮的起始tag，默认9000
@property (nonatomic, assign)   NSInteger tagButton;
//! 标题栏两个按钮之间的最小间距
@property (nonatomic, assign)   CGFloat titlePadding;
//! 标题栏顶部文字的颜色，默认为RGBA(0.1, 0.3, 0.9, 1.0)
@property (nonatomic, strong)   UIColor * colorUpper;
//! 标题栏底部文字的颜色，默认为RGBA(0.1, 0.3, 0.9, 0.7)
@property (nonatomic, strong)   UIColor * colorLower;
//! 标题栏的背景色，默认为白色
@property (nonatomic, strong)   UIColor * colorTitleBack;


@end
