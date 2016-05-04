//
//  XYNearDriverSchoolSelectTableView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYNearDriverSchoolSelectTableView, XYAddActionView;
typedef void(^ didSelctRow)(XYNearDriverSchoolSelectTableView * tableView, NSIndexPath * indexPath);

@interface XYNearDriverSchoolSelectTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray * groupArray;

@property (nonatomic, strong)XYAddActionView * backgroudView;


@property (nonatomic, copy)didSelctRow didSelctRow;
- (void)didSelectRowWithBlock:(void(^)(XYNearDriverSchoolSelectTableView * tableView, NSIndexPath * indexPath))didSelctRow;
@end
