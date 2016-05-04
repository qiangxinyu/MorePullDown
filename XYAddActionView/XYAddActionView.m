//
//  XYAddActionView.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYAddActionView.h"

@implementation XYAddActionView

- (void)clickView:(void (^)(UIView *))clickView
{
    self.userInteractionEnabled = YES;
    self.clickView = clickView;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.clickView ? self.clickView(self) : 0;
}
@end
