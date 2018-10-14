//
//  CCSubVC1.m
//  CCSlider
//
//  Created by Chen on 2018/10/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

#import "CCSubVC1.h"

@interface CCSubVC1 () <UITableViewDelegate, UITableViewDataSource>

//! tableView
@property (nonatomic, strong)   UITableView * tableView;

@end

@implementation CCSubVC1

- (instancetype)init {
    if (self = [super init]) {
        _tableView = ({
            UITableView * table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            table.delegate = self;
            table.dataSource = self;
            table;
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView delegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const nCellId = @"DefaultCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:nCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nCellId];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}


@end
