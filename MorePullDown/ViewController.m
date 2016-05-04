//
//  XYNearDriverSchoolViewController.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XYNearDriverSchoolSelectView.h"
#import "XYNearDriverSchoolSelectTableView.h"
#import "XYAddActionView.h"


#import "XYButton.h"

@interface ViewController ()
@property (nonatomic, strong)NSMutableArray * groupArray;
@property (nonatomic, strong)XYNearDriverSchoolSelectView * selectView;

@property (nonatomic, strong)XYNearDriverSchoolSelectTableView * selectTableView;


@property (nonatomic, weak)XYButton * oldBtn;
/**
 *  处于 显示 模式的btn
 */
@property (nonatomic, weak)XYButton * showBtn;

@end

static NSString * cell_key = @"cell";

@implementation ViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = kDefaultBackgroudColor;
    
    //这是页面的内容
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectView.frame) + 1, kScreenWidth, kScreenHeight -  CGRectGetMaxY(self.selectView.frame) - 1 - kNavigationBar_Height)];
    imageView.image = kImage(@"image");
    imageView.backgroundColor = kWhiteColor;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    
    [self.view addSubview:self.selectTableView.backgroudView];
    [self.selectTableView.backgroudView clickView:^(UIView *view) {
        [self.showBtn touchesEnded:[NSSet set] withEvent:nil];
    }];
    
    [self.view addSubview:self.selectTableView];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.view addSubview:self.selectView];

   
}

#pragma mark -------------------------------------------------------
#pragma mark Innder Method

- (void)clickSelectViewWithBth:(XYButton *)btn
{
    NSInteger y = CGRectGetMaxY(self.selectView.frame) + 1;
    if (!btn.isShow) {
        y = - self.selectTableView.height;
    }
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.selectTableView.mj_y = y;
    }];
    
    self.oldBtn = btn;
    
    self.selectTableView.backgroudView.hidden = !self.showBtn.isShow;
}


#pragma mark -------------------------------------------------------
#pragma mark LazyLoading
- (XYNearDriverSchoolSelectView *)selectView
{
    if (!_selectView) {
        _selectView = [[XYNearDriverSchoolSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        
        
        WeakSelf(weakSelf);
        
        
        
        NSMutableArray * groupArray = @[].mutableCopy;
        for (int i = 0 ; i < 4 ; i ++) {
            NSMutableArray * array = @[].mutableCopy;
            for (int i = 0 ; i < (arc4random()% 40) + 1; i ++) {
                [array addObject:[NSString stringWithFormat:@"%d",(arc4random()% 40)]];
            }
            
            [groupArray addObject:array];
        }
        
        
        [_selectView clickSelectView_blockWithBlock:^(XYButton *btn) {
           
            
            if (btn.isShow) {
                self.showBtn = btn;
                self.selectTableView.backgroudView.hidden = NO;
                NSLog(@" -- %@",btn.titleLabel.text);

                
                
                weakSelf.selectTableView.groupArray = groupArray[btn.tag - 100000];
            }
           
            
            if (self.oldBtn != btn && self.oldBtn.isShow) {
                
                [self.oldBtn touchesEnded:[NSSet set] withEvent:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHomeCityAnimate_time / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf clickSelectViewWithBth:btn];
                    
                });
            } else {
                [weakSelf clickSelectViewWithBth:btn];
            }
            
        }];
    }
    return _selectView;
}

- (XYNearDriverSchoolSelectTableView *)selectTableView
{
    if (!_selectTableView) {
        _selectTableView = [[XYNearDriverSchoolSelectTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        [_selectTableView didSelectRowWithBlock:^(XYNearDriverSchoolSelectTableView *tableView, NSIndexPath *indexPath) {
            
        }];
    }
    return _selectTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
