//
//  CCSubVC2.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCSubVC2.h"

@interface CCSubVC2 ()

@end

@implementation CCSubVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30)];
        lbl.text = @"这是一个页面";
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl;
    })];
}



@end
