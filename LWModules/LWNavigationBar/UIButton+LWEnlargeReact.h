//
//  UIButton+LWEnlargeReact.h
//  LWModules
//
//  Created by apple on 2018/4/2.
//  Copyright © 2018年 apple. All rights reserved.
//


/*copy*/

#import <UIKit/UIKit.h>

@interface UIButton (LWEnlargeReact)

/**
 *  @author hj, 06.27 2016 20:06
 *
 *  同时向按钮的四个方向延伸响应面积
 *
 *  @param size 间距
 */
- (void)setEnlargeEdge:(CGFloat) size;

/**
 *  @author hj, 06.27 2016 20:06
 *
 *  向按钮的四个方向延伸响应面积
 *
 *  @param top    上间距
 *  @param left   左间距
 *  @param bottom 下间距
 *  @param right  右间距
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top left:(CGFloat) left bottom:(CGFloat) bottom right:(CGFloat) right;

@end
