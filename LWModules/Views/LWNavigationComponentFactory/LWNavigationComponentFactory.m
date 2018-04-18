//
//  LWNavigationComponentFactory.m
//  LWModules
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWNavigationComponentFactory.h"

@interface LWNavigationComponentFactory()

@property(nonatomic, copy)UILabel *(^navigationLabelRecipe)(UILabel *templetLabel);

@property(nonatomic, copy)UIButton *(^returnButtonRecipe)(UIButton *templetButton);

@property(nonatomic, copy)UIButton *(^nextButtonRecipe)(UIButton *templetButton);

@end

@implementation LWNavigationComponentFactory

+ (instancetype)shareInstance{
    static LWNavigationComponentFactory *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[self alloc] init];
        share.navigationLabelRecipe = ^UILabel *(UILabel *templetLabel) {
            return templetLabel;
        };
        share.returnButtonRecipe = ^UIButton *(UIButton *templetButton) {
            return templetButton;
        };
        share.nextButtonRecipe = ^UIButton *(UIButton *templetButton) {
            return templetButton;
        };
    });
    return share;
}

- (void)configNavigationLabelRecipe:(UILabel *(^)(UILabel *))recipeBlock{
    self.navigationLabelRecipe = recipeBlock;
}

- (void)configReturnButtonRecipe:(UIButton *(^)(UIButton *))recipeBlock{
    self.returnButtonRecipe = recipeBlock;
}

- (void)configNextButtonRecipe:(UIButton *(^)(UIButton *))recipeBlock{
    self.nextButtonRecipe = recipeBlock;
}

- (UILabel *)produceNavigationLabel{
    UILabel *label = [[UILabel alloc] init];
    return self.navigationLabelRecipe(label);
}
- (UIButton *)produceReturnButton{
    UIButton *button = [[UIButton alloc] init];
    return self.returnButtonRecipe(button);
}
- (UIButton *)produceNextButton{
    UIButton *button = [[UIButton alloc] init];
    return self.nextButtonRecipe(button);
}

@end
