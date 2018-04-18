//
//  LWEditableLabel.h
//  LWModules
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWEditableLabel : UIView

@property(nonatomic, strong, readonly)UILabel *label;

@property(nonatomic, strong, readonly)UITextField *textField;


@property(nonatomic, strong)UIFont *font;
@property(nonatomic, copy)NSString *text;

@property(nonatomic, copy)UIColor *labelColor;
@property(nonatomic, copy)UIColor *textFieldColor;

- (void)edit;
- (void)completeEdit;

@end
