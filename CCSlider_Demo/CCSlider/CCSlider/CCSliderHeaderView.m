//
//  CCSliderHeaderView.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCSliderHeaderView.h"

@interface CCSliderHeaderView ()

//! header中所有按钮的title
@property (nonatomic, strong)   NSMutableArray * arrTitles;
//! 当前按钮在坐标中的y值，即下一按钮y轴上的起始位置，初始时其值为5
@property (nonatomic, assign)   CGFloat currentOriginY;
//! 当前选中哪个按钮
@property (nonatomic, assign)   NSInteger currentSelectedIndex;


//! scrollView
@property (nonatomic, strong)   UIScrollView * scrollView;
//! 上层view
@property (nonatomic, strong)   UIView * vUpper;
//! 下层view
@property (nonatomic, strong)   UIView * vLower;

//! 上层的线条
@property (nonatomic, strong, readwrite)     UIView * vLineUpper;
//! 下层的线条
@property (nonatomic, strong, readwrite)     UIView * vLineLower;


@end

@implementation CCSliderHeaderView

//! 初始化，带上配置信息
- (instancetype)initWithFrame:(CGRect)frame andConfig:(CCSliderConfig *)config {
    if (self = [super initWithFrame:frame]) {
        _cc_config = config;
        self.backgroundColor = _cc_config.colorTitleBack;;
        _arrTitles = [NSMutableArray new];
        _currentSelectedIndex = 0;
        _currentOriginY = _cc_config.titlePadding;
        _colorLower = _cc_config.colorLower;
        _colorUpper = _cc_config.colorUpper;
        CGFloat height = 45<=frame.size.height ? 45 : frame.size.height;
        _vLineUpper = ({
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(-999, height-1.2, 1999, 1.2)];
            line.backgroundColor = _cc_config.colorUpper;
            line;
        });
        _vLineLower = ({
            UIView * line = [[UIView alloc] initWithFrame:CGRectMake(-999, height-1.2, 1999, 1.2)];
            line.backgroundColor = _cc_config.colorLower;
            line;
        });
        _vUpper = ({
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-height, 0, height)];
            view.backgroundColor = [UIColor clearColor];
            view.clipsToBounds = YES;
            [view addSubview:_vLineUpper];
            view;
        });
        _vLower = ({
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-height, frame.size.width, height)];
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:_vLineLower];
            view;
        });
        _scrollView = ({
            UIScrollView * scl = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            scl.backgroundColor = [UIColor clearColor];
            scl.showsHorizontalScrollIndicator = NO;
            scl.showsVerticalScrollIndicator = NO;
            [scl addSubview:_vLower];
            [scl addSubview:_vUpper];
            scl;
        });
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _scrollView.frame = self.bounds;
    _vLower.frame = self.bounds;
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex {
    if (currentSelectedIndex>=0 && currentSelectedIndex<=_arrTitles.count) {
        _currentSelectedIndex = currentSelectedIndex;
    }
}

- (void)setColorLower:(UIColor *)colorLower {
    _colorLower = colorLower;
    for (UIView * view in _vLower.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * tmpBtn = (UIButton *)view;
            [tmpBtn setTitleColor:colorLower forState:UIControlStateNormal];
        } else if ([view isKindOfClass:[UILabel class]]) {
            UILabel * tmpLbl = (UILabel *)view;
            tmpLbl.textColor = colorLower;
        } else {
            view.backgroundColor = colorLower;
        }
    }
}

- (void)setColorUpper:(UIColor *)colorUpper {
    _colorUpper = colorUpper;
    for (UIView * view in _vLower.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * tmpBtn = (UIButton *)view;
            [tmpBtn setTitleColor:colorUpper forState:UIControlStateNormal];
        } else if ([view isKindOfClass:[UILabel class]]) {
            UILabel * tmpLbl = (UILabel *)view;
            tmpLbl.textColor = colorUpper;
        } else {
            view.backgroundColor = colorUpper;
        }
    }
}

#pragma mark - public

- (void)clear {
    for (int i = 0; i < _arrTitles.count; i ++) {
        UIButton * btn1 = [_vLower viewWithTag:_cc_config.tagButton+i];
        UIButton * btn2 = [_vUpper viewWithTag:_cc_config.tagButton+i];
        [btn1 removeFromSuperview];
        [btn2 removeFromSuperview];
    }
    _currentOriginY = _cc_config.titlePadding;
    [_arrTitles removeAllObjects];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

//! 将headerView中的按钮置为titles。当按钮数量不多时，此方法会平均分配每个按钮的宽度，直至占满屏幕
- (void)setTitles:(NSArray *)titles {
    [self clear];
    CGFloat tmpWidth = 0;
    for (NSString * aTitle in titles) {
        tmpWidth += [self getButtonSizeWithTitle:aTitle].width;
    }
    //! 按钮数量过多，超过屏幕宽度，则使用默认的添加方法
    if (tmpWidth>CC_ScreenWidth) {
        [self addTitles:titles];
    }
    //! 按钮无法占满屏幕，则平均分配其宽度，使它占满屏幕
    else {
        _currentOriginY = 0;
        for (NSString * aTitle in titles) {
            CGRect btnFrame = CGRectMake(_currentOriginY, 5, CC_ScreenWidth/titles.count, self.frame.size.height);
            [_arrTitles addObject:aTitle];
            [self addButtonWithTitle:aTitle andFrame:btnFrame];
        }
    }
    if (_arrTitles.count) {
        [self selectButtonAtIndex:0];
    }
}

//! 添加多个按钮
- (void)addTitles:(NSArray *)titles {
    for (NSString * title in titles) {
        [self addTitle:title];
    }
}

//! 添加一个按钮
- (void)addTitle:(NSString *)title {
    [_arrTitles addObject:title];
    CGSize titleSize = [self getButtonSizeWithTitle:title];
    CGRect btnFrame = CGRectMake(_currentOriginY, 5, titleSize.width, self.vUpper.frame.size.height);
    [self addButtonWithTitle:title andFrame:btnFrame];
}

//! 根据按钮的title和frame向两个view中添加一个按钮
- (void)addButtonWithTitle:(NSString *)title andFrame:(CGRect)frame {
    UIButton * btnLower = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = _cc_config.tagButton + _arrTitles.count-1;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_colorLower forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:_cc_config.fontDefault.pointSize];
        btn.frame = frame;
        btn;
    });
    UIButton * btnUpper = ({
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = _cc_config.tagButton + _arrTitles.count-1;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_colorUpper forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:_cc_config.fontDefault.pointSize];
        btn.frame = frame;
        btn;
    });
    [_vUpper addSubview:btnUpper];
    [_vLower addSubview:btnLower];
    
    _currentOriginY += frame.size.width;
    _scrollView.contentSize = CGSizeMake(_currentOriginY, CGRectGetHeight(_scrollView.frame));
    _vLower.frame = CGRectMake(_vLower.frame.origin.x, _vLower.frame.origin.y, _currentOriginY, _vLower.frame.size.height);
}


//! 选中某个button，调整upperView以显示正确的选中状态
- (void)selectButtonAtIndex:(NSInteger)index {
    _currentSelectedIndex = index;
    UIButton * btn = (UIButton *)[_vUpper viewWithTag:index+_cc_config.tagButton];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.vUpper.bounds = CGRectMake(CGRectGetMinX(btn.frame), 0, CGRectGetWidth(btn.frame), CGRectGetHeight(weakSelf.vUpper.frame));
        weakSelf.vUpper.frame = CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMinY(weakSelf.vUpper.frame), CGRectGetWidth(btn.frame), CGRectGetHeight(weakSelf.vUpper.frame));
    }];
    
    if (btn.center.x-_scrollView.frame.size.width/2>=0 && btn.center.x+_scrollView.frame.size.width/2<=_scrollView.contentSize.width) {
        [_scrollView scrollRectToVisible:CGRectMake(btn.center.x-_scrollView.frame.size.width/2, CGRectGetMinY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) animated:YES];
    }
    //  当选中的按钮在scrollview的右侧时，scroll向右滑动
    else if (btn.center.x-_scrollView.frame.size.width/2>=0) {
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentSize.width-_scrollView.frame.size.width, CGRectGetMinY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) animated:YES];
    }
    //  当选中的按钮在scrollview的左侧时，scroll向左滑动
    else if (btn.center.x+_scrollView.frame.size.width/2<=_scrollView.contentSize.width) {
        [_scrollView scrollRectToVisible:CGRectMake(0, CGRectGetMinY(_scrollView.frame), CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) animated:YES];
    }
}

- (void)scrollWithProgress:(float)progress {
    if (fabsf(progress-_currentSelectedIndex)>=1) {
        self.currentSelectedIndex += (int)(progress-_currentSelectedIndex);
    }
    //  目标按钮的index
    NSInteger destIndex;
    float aProgress = 0;
    if (ceilf(progress)==_arrTitles.count) {
        destIndex = _arrTitles.count-1;
    } else if (progress>_currentSelectedIndex) {
        destIndex = ceilf(progress);
        aProgress = progress-(int)progress;
    } else {
        destIndex = floorf(fabsf(progress));
        aProgress = progress - ceilf(progress);
    }
    CGRect frameCur = [_vUpper viewWithTag:_currentSelectedIndex+ _cc_config.tagButton].frame;
    CGRect frameDest = [_vUpper viewWithTag:destIndex+_cc_config.tagButton].frame;
    CGFloat destWidth = (frameDest.size.width-frameCur.size.width)*fabsf(aProgress)+frameCur.size.width;
    CGFloat destX = (frameDest.origin.x-frameCur.origin.x)*fabsf(aProgress)+frameCur.origin.x;
    _vUpper.bounds = CGRectMake(destX, 0, destWidth, CGRectGetHeight(_vUpper.bounds));
    _vUpper.frame = CGRectMake(destX, CGRectGetMinY(_vUpper.frame), destWidth, CGRectGetHeight(_vUpper.frame));
}


#pragma mark - 在view上添加按钮的相关方法

//! 根据title的文字内容，获取此按钮的尺寸
- (CGSize)getButtonSizeWithTitle:(NSString *)title {
    CGSize titleSize = [self cc_stringSizeWithSize:CGSizeMake(200, 40) font:[UIFont systemFontOfSize:_cc_config.fontDefault.pointSize] string:title];
    CGSize btnSize = CGSizeMake(titleSize.width+2*_cc_config.titlePadding, 40);
    return btnSize;
}

//! 根据字体大小获取字符串的size
- (CGSize)cc_stringSizeWithSize:(CGSize)maxSize font:(UIFont *)font string:(NSString *)string {
    if (self == nil || [self isKindOfClass:[NSNull class]]) {
        return CGSizeZero;
    }
    CGSize stringSize;
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    if ([self respondsToSelector:@selector(boundingRectWithSize: options:attributes:context:)]) {
        stringSize = [string boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil].size;
    } else {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
        [attrStr addAttribute:NSFontAttributeName value:font range:[string rangeOfString:string]];
        stringSize = [attrStr boundingRectWithSize:maxSize options:options context:nil].size;
    }
    return stringSize;
}


#pragma mark - onClick

//! 点击header上的按钮，同时触发delegate
- (void)onClickButton:(UIButton *)sender {
    NSInteger buttonIndex = sender.tag-_cc_config.tagButton;
    [self selectButtonAtIndex:buttonIndex];
    if ([self.delegate respondsToSelector:@selector(header:didSelectItemAtIndex:)]) {
        [self.delegate header:self didSelectItemAtIndex:buttonIndex];
    }
}


@end
