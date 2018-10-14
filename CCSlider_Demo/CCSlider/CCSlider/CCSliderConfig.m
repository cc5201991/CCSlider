//
//  CCSliderConfig.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCSliderConfig.h"

@implementation CCSliderConfig

- (instancetype)init {
    if (self = [super init]) {
        _titleHeight = 45;
        _fontDefault = [UIFont systemFontOfSize:17];
        _tagButton = 9000;
        _titlePadding = 8;
        _colorUpper = [UIColor colorWithRed:0.1 green:0.3 blue:0.9 alpha:1];
        _colorLower = [UIColor colorWithRed:0.1 green:0.3 blue:0.9 alpha:0.5];
        _colorTitleBack = [UIColor whiteColor];
    }
    return self;
}


@end
