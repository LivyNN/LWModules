//
//  LWFlowLayoutView.h
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWFlowLayoutView : UIView

@property(nonatomic, copy, readonly)NSArray<UIView *> *currentViewArray;
@property(nonatomic, copy, readonly)NSArray<NSNumber *> *currentViewHeightArray;

/*流布局只能在末尾加，移除可以任意处移除*/
- (void)lw_InsertSubView:(UIView *)view height:(CGFloat)viewHeight;
- (void)lw_RemoveSubViewAtRow:(NSInteger)row;
- (void)lw_RemoveSubView:(UIView *)view;

@end
