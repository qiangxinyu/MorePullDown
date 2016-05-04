//
//  XYNearDriverSchoolSelectTableView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYNearDriverSchoolSelectTableView.h"
#import "XYAddActionView.h"

static NSString * cell_key = @"cell_key";

@implementation XYNearDriverSchoolSelectTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self layoutViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if ([super initWithFrame:frame style:style]) {
        [self layoutViews];
    }
    return self;
}

//- update

#pragma mark -------------------------------------------------------
#pragma mark Inner Method

- (void)layoutViews
{
    self.backgroundColor = kDefaultBackgroudColor;
    self.tableFooterView = [UIView new];
    self.delegate = self;
    self.dataSource = self;
    
    [self registerClass:UITableViewCell.class forCellReuseIdentifier:cell_key];
}

#pragma mark -------------------------------------------------------
#pragma mark Setting

- (void)setGroupArray:(NSMutableArray *)groupArray
{
    _groupArray = groupArray;
    
    self.height = groupArray.count * 25;
    [self reloadData];
}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)didSelectRowWithBlock:(void (^)(XYNearDriverSchoolSelectTableView *, NSIndexPath *))didSelctRow
{
    self.didSelctRow = didSelctRow;
}


#pragma mark -------------------------------------------------------
#pragma mark TableView DataSource & Delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_key forIndexPath:indexPath];
    cell.textLabel.text = self.groupArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelctRow ? self.didSelctRow(self, indexPath) : 0;
}


#pragma mark -------------------------------------------------------
#pragma mark Lazy Loading

- (XYAddActionView *)backgroudView
{
    if (!_backgroudView) {
        _backgroudView = [[XYAddActionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _backgroudView.backgroundColor = [UIColor blackColor];
        _backgroudView.alpha = .7;
        _backgroudView.hidden = YES;
    }
    return _backgroudView;
}



@end
