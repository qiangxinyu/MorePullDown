//
//  XYAddActionView.h
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickView)(UIView * view);

@interface XYAddActionView : UIView
@property (nonatomic, copy)clickView clickView;

- (void)clickView:(void(^)(UIView * view))clickView;
@end
