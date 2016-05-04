//
//  XYButton.m
//  zhaoZhaoBa
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYButton.h"
@implementation XYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews
{
    self.backgroundColor = kWhiteColor;
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 12, self.height)];
    _titleLabel.textColor = kNavigationBarTextColor;
    _titleLabel.font = [UIFont systemFontOfSize:9];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"正在定位..";
    
    [self addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.width, self.height / 2 - 3, 12, 6)];
    self.imageView.image = kImage(@"下角标");
    [self addSubview:self.imageView];
}


- (void)touchesEnded
{
    self.isShow = !self.isShow;
    
    [UIView animateWithDuration:kHomeCityAnimate_time animations:^{
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded];
    
    self.clickCityBtn_block_xyButton ? self.clickCityBtn_block_xyButton(self) : 0;
    
    
    
    
}

#pragma mark -------------------------------------------------------
#pragma mark Method

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    
    CGFloat width = [title boundingRectWithSize:CGSizeMake(222, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9]} context:nil].size.width;
    
    if (width > self.width - 12) {
        width = self.width - 12;
    }
    
    self.titleLabel.width = width;
    self.titleLabel.mj_x  = self.width / 2 - (width + 12 + 2) / 2;
    
    self.imageView.mj_x = CGRectGetMaxX(self.titleLabel.frame) + 2;
    
}


- (void)clickCityBtn_block_xyButton:(void (^)(XYButton *))clickCityBtn_block_xyButton
{
    self.clickCityBtn_block_xyButton = clickCityBtn_block_xyButton;
}

@end
