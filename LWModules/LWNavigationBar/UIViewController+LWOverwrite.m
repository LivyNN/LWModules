//
//  UIViewController+LWOverwrite.m
//  LWModules
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIViewController+LWOverwrite.h"
#import <Masonry.h>
#import "UIButton+LWEnlargeReact.h"

@implementation UIViewController (LWOverwrite)
- (void)overwriteNavigationBarWithColor:(UIColor *)color
                           andTitleView:(UIView *)titleView
                          andLeftButton:(UIButton *)leftButton
                       andOneRigtButton:(UIButton *)rightButton
                               leftSize:(CGSize)leftSize
                           andRightSize:(CGSize)rightSize{
    self.navigationController.navigationBar.barTintColor = color;
    if (nil != leftButton) {
        //左边的不为空的时候 加上去
        UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        leftButton.frame = CGRectMake(0, 0, leftSize.width, leftSize.height);
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(leftSize.height);
            make.width.mas_equalTo(leftSize.width);
        }] ;

        self.navigationItem.leftBarButtonItem = leftBarButton;
        
    }else{
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor] ;
        UIBarButtonItem *item                             = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem             = item;
    }
    //设置右侧的按钮
    if (nil != rightButton) {
        //右边的不为空的时候 加上去
        UIBarButtonItem* rightBarButton        = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        rightButton.frame                      = CGRectMake(0, 0, rightSize.width, rightSize.height);
        
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rightSize.height);
            make.width.mas_equalTo(rightSize.width);
        }] ;
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    float enlargeTop = 0;
    float enlargeLeft = 0;
    float enlargeBottom = 0;
    float enlargeRight = 0;
    enlargeBottom = enlargeTop = (44 - leftSize.height)/2>0?(44 - leftSize.height)/2:0 ;
    enlargeLeft = enlargeRight = (44 - leftSize.width)/2>0?(44 - leftSize.width)/2:0;
    [leftButton setEnlargeEdgeWithTop:enlargeTop left:enlargeLeft bottom:enlargeBottom right:enlargeRight];
    
    enlargeBottom = enlargeTop = (44 - rightSize.height)/2>0?(44 - rightSize.height)/2:0 ;
    enlargeLeft = enlargeRight = (44 - rightSize.width)/2>0?(44 - rightSize.width)/2:0;
    [rightButton setEnlargeEdgeWithTop:enlargeTop left:enlargeLeft bottom:enlargeBottom right:enlargeRight];
    
    //设置标题视图
    if (nil != titleView) {
        self.navigationItem.titleView = titleView;
    }
}

- (void)overWriteDefaultNavigationBarWithLeftButton:(UIButton *)leftButton rightButton:(UIButton *)rightButton titleView:(UIView *)titleView{
    [self overwriteNavigationBarWithColor:[UIColor whiteColor] andTitleView:titleView andLeftButton:leftButton andOneRigtButton:rightButton leftSize:CGSizeMake(self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height) andRightSize:CGSizeMake(self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.height)];
}
@end
