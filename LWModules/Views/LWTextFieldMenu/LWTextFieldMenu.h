//
//  LWTextFieldMenu.h
//  LWModules
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWTextFieldMenuDataSource
@required
- (NSArray<NSString *> *)LWTextFieldMenuShowArray;

@optional
- (UIImage *)LWTextFieldMenuItemDeleteButtonImage;
- (BOOL)LWTextFieldMenuItemDeleteEnable;
- (CGFloat)LWTextFieldMenuItemHeight;
- (CGFloat)LWTextFieldMenuMaxHeight;

- (UIFont *)LWTextFieldMenuItemTitleFont;
- (UIColor *)LWTextFieldMenuItemTitleColor;

@end


@protocol LWTextFieldMenuDelegate
@optional

- (void)LWTextFieldMenuItemSelected:(NSInteger)index;
- (void)LWTextFieldMenuItemDeleted:(NSInteger)index;

@end

//点击输入框出现的menu，常用于记录的账号密码的显示

@interface LWTextFieldMenu : UIView

@property(nonatomic, weak)NSObject<LWTextFieldMenuDataSource> *dataSource;
@property(nonatomic, weak)NSObject<LWTextFieldMenuDelegate> *delegate;
@property(nonatomic, weak)UIView *lwSuperView;
@property(nonatomic, weak)UIView *lwTargetView;

- (void)layoutWithTargetView:(UIView *)targetView inSuperView:(UIView *)superView;

- (void)reloadData;

- (void)showWithAnimation:(BOOL)animation;
- (void)hidWithAnimation:(BOOL)animation;

@end
