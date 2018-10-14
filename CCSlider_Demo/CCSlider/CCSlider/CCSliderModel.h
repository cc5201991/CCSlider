//
//  CCSliderModel.h
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCSliderModel : NSObject

//! 标题
@property (nonatomic, copy)     NSString * strTitle;
//! 页面，strClassName和vcSlider必须有一个有值
@property (nonatomic, copy)     NSString * strClassName;
@property (nonatomic, strong)   UIViewController * vcSlider;
//! tag
@property (nonatomic, assign)   NSInteger intTag;


@end
