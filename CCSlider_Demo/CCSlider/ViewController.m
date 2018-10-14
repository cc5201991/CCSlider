//
//  ViewController.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "ViewController.h"
#import "CCSubVC1.h"
#import "CCSubVC2.h"
#import "CCSlider.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

//! tableView
@property (nonatomic, strong)   UITableView * tableView;

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        _tableView = ({
            UITableView * table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            table.delegate = self;
            table.dataSource = self;
            table.rowHeight = UITableViewAutomaticDimension;
            table.estimatedRowHeight = 44;
            table;
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_initView];
}

- (void)p_initView {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const nCellId = @"DefaultCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nCellId];
    }
    
    cell.textLabel.text = @"点击跳转";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < indexPath.row+1; i ++) {
        CCSliderModel * model = [CCSliderModel new];
        model.strTitle = [NSString stringWithFormat:@"页面 %d",i];
        model.strClassName = @"CCSubVC1";
        [array addObject:model];
    }
    CCSliderMngVC * vc = [[CCSliderMngVC alloc] initWithModels:array config:[CCSliderConfig new] selIndex:indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
