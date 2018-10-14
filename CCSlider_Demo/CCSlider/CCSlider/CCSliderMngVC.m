//
//  CCSliderMngVC.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCSliderMngVC.h"
#import "CCSliderHeaderView.h"

@interface CCSliderMngVC () <UIScrollViewDelegate, CCSliderHeaderViewDelegate>

//! headerView
@property (nonatomic, strong)   CCSliderHeaderView * vHeader;
//! contentView
@property (nonatomic, strong)   UIScrollView * scrollView;

//! 子页面数组
@property (nonatomic, strong)   NSArray <CCSliderModel*>* arrVC;
//! 当前显示第几个子页面，在初始化时设置，默认为0
@property (nonatomic, assign)   NSInteger showIndex;


@end

@implementation CCSliderMngVC

//! 初始化
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array {
    return [self initWithModels:array config:[CCSliderConfig new]];
}

//! 初始化，带上配置信息
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array config:(CCSliderConfig *)config {
    return [self initWithModels:array config:config selIndex:0];
}

//! 初始化，index表示当前显示第几个页面
- (instancetype)initWithModels:(NSArray <CCSliderModel*>*)array config:(CCSliderConfig *)config selIndex:(NSInteger)index {
    if (self = [super init]) {
        _arrVC = array;
        _showIndex = index >=0 ? index : 0;
        _vHeader = ({
            CCSliderHeaderView * view = [[CCSliderHeaderView alloc] initWithFrame:CGRectMake(0, 0, CC_ScreenWidth, config.titleHeight) andConfig:config];
            view.delegate = self;
            view.vLineLower.hidden = YES;
            view;
        });
        _scrollView = ({
            UIScrollView * scl = [[UIScrollView alloc] initWithFrame:CGRectZero];
            scl.backgroundColor = CC_HexColor(0xf7f7f7);
            scl.delegate = self;
            scl.pagingEnabled = YES;
            scl.showsHorizontalScrollIndicator = NO;
            scl.showsVerticalScrollIndicator = NO;
            scl;
        });
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_scrollView.panGestureRecognizer requireGestureRecognizerToFail:[self p_screenEdgePanGestureRecognizer]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_initView];
}

//!
- (void)p_initView {
    [self.scrollView setContentSize:CGSizeMake(CC_ScreenWidth*_arrVC.count, 0)];
    self.scrollView.frame = CGRectMake(0, _vHeader.frame.size.height, CC_ScreenWidth, self.view.frame.size.height-_vHeader.frame.size.height);
    
    [self.view addSubview:_vHeader];
    [self.view addSubview:_scrollView];
    
    NSMutableArray * arrTitle = [NSMutableArray new];
    for (CCSliderModel * model in _arrVC) {
        [arrTitle addObject:model.strTitle];
    }
    [_vHeader setTitles:arrTitle];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //! 显示选中的那个页面
        [weakSelf p_scrollAtIndex:weakSelf.showIndex];
        [weakSelf.vHeader selectButtonAtIndex:weakSelf.showIndex];
    });
}


- (void)p_scrollAtIndex:(NSInteger)index {
    if (_arrVC.count<=index) {
        return;
    }
    [_scrollView setContentOffset:CGPointMake(index*_scrollView.frame.size.width, _scrollView.contentOffset.y) animated:NO];
    CCSliderModel * model = _arrVC[index];
    if (!model.vcSlider) {
        UIViewController * subVC;
        Class aClass = NSClassFromString(model.strClassName);
        if (aClass) {
            subVC = [[aClass alloc] init];
            subVC.view.frame = CGRectMake(index*CC_ScreenWidth, 0, CC_ScreenWidth, self.scrollView.frame.size.height);
            model.vcSlider = subVC;
            [self.scrollView addSubview:subVC.view];
            [self addChildViewController:subVC];
        }
    }
}

#pragma mark - private

- (UIScreenEdgePanGestureRecognizer *)p_screenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.navigationController.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.navigationController.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}


#pragma mark - 通知
//! 根据通知传来的tag，跳转到对应tag的页面
- (void)dteOperateScrollNotification:(NSNotification *)noti {
    [self p_scrollAtIndex:0];
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float theProgress = scrollView.contentOffset.x/scrollView.frame.size.width;
    [_vHeader scrollWithProgress:theProgress];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentSelectIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    [_vHeader selectButtonAtIndex:currentSelectIndex];
    
    [self p_scrollAtIndex:currentSelectIndex];
}

#pragma mark - CCSliderHeaderView delegate
//! 点击了某个按钮(只在点击的时候才触发delegate)
- (void)header:(CCSliderHeaderView *)headerView didSelectItemAtIndex:(NSInteger)index {
    [_scrollView setContentOffset:CGPointMake(index*_scrollView.frame.size.width, _scrollView.contentOffset.y) animated:NO];
    [self p_scrollAtIndex:index];
}




@end
