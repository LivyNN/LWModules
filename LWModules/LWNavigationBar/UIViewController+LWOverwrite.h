//
//  UIViewController+LWOverwrite.h
//  LWModules
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LWOverwrite)

- (void)lw_overwriteNavigationBarWithColor:(UIColor *)color
                           andTitleView:(UIView *)titleView
                          andLeftButton:(UIButton *)leftButton
                       andOneRigtButton:(UIButton *)rightButton
                               leftSize:(CGSize)leftSize
                           andRightSize:(CGSize)rightSize;

- (void)lw_overWriteDefaultNavigationBarWithLeftButton:(UIButton *)leftButton rightButton:(UIButton *)rightButton titleView:(UIView *)titleView;


@end
