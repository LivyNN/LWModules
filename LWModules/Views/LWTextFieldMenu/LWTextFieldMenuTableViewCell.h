//
//  LWTextFieldMenuTableViewCell.h
//  LWModules
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const kLWTextFieldMenuTableViewCell;

@interface LWTextFieldMenuTableViewCell : UITableViewCell

@property(nonatomic, strong, readonly)UILabel *itemLabel;

@property(nonatomic, strong, readonly)UIButton *deleteButton;

@end
