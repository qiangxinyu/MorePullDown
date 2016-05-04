//
//  XYNearDriverSchoolSelectView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/5/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYButton;

typedef void (^clickSelectView_block)(XYButton * btn);

@interface XYNearDriverSchoolSelectView : UIView

@property (nonatomic, copy)clickSelectView_block clickSelectView_block;
- (void)clickSelectView_blockWithBlock:(void(^)(XYButton * btn))clickSelectView_block;

@end
