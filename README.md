# CCSlider
顶部滑动菜单，类似网易新闻、今日头条

效果图：

![image](https://github.com/cc5201991/CCSlider/blob/master/CCSlider1.gif)
![image](https://github.com/cc5201991/CCSlider/blob/master/CCSlider2.gif)


初始化示例：

    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < 6; i ++) {
        CCSliderModel * model = [CCSliderModel new];
        //! 标题
        model.strTitle = [NSString stringWithFormat:@"页面 %d",i];
        //! 子页面的类名
        model.strClassName = @"CCSubVC1";
        [array addObject:model];
    }
    //! 对ui进行配置
    CCSliderConfig * config = [CCSliderConfig new];
    config.titleHeight = 64;
    config.colorTitleBack = CC_HexColor(0x49a7f6);
    config.colorUpper = [UIColor whiteColor];
    config.colorLower = CC_HexColor(0xf5f5f5);
    
    CCSliderMngVC * vc = [[CCSliderMngVC alloc] initWithModels:array config:config selIndex:0];
    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc];
