//
//  LWNavigationComponentFactory.h
//  LWModules
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*navigation 是全局都用到且需要统一格式定做的东西，因此必须提倡使用工厂模式统一生产，其好处就是有利于修改*/

@interface LWNavigationComponentFactory : NSObject

+ (instancetype)shareInstance;

- (void)configNavigationLabelRecipe:(UILabel *(^)(UILabel *templetLabel))recipeBlock;
- (void)configReturnButtonRecipe:(UIButton *(^)(UIButton *templetButton))recipeBlock;
- (void)configNextButtonRecipe:(UIButton *(^)(UIButton *templetButton))recipeBlock;


- (UILabel *)produceNavigationLabel;
- (UIButton *)produceReturnButton;
- (UIButton *)produceNextButton;
@end
