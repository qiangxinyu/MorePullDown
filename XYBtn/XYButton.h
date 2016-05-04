//
//  XYButton.h
//  ;
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYButton;

typedef void(^ clickCityBtn_block_xyButton)(XYButton * view);


@interface XYButton : UIView

@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UIImageView * imageView;


- (void)setTitle:(NSString *)title;

/**
 *  是否 是 显示模式  YES  显示
 */
@property (nonatomic, assign)BOOL isShow;


@property (nonatomic, copy)clickCityBtn_block_xyButton clickCityBtn_block_xyButton;
- (void)clickCityBtn_block_xyButton:(void(^)(XYButton * view))clickCityBtn_block_xyButton;

@end
