//
//  LWTextFieldMenu.m
//  LWModules
//
//  Created by apple on 2018/4/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWTextFieldMenu.h"
#import "LWTextFieldMenuTableViewCell.h"
#import <Masonry.h>

@interface LWTextFieldMenu()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong, readwrite)UITableView *menuTableView;

@end

@implementation LWTextFieldMenu

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubviews];
        [self addConstraints];
        self.hidden = YES;
    }
    return self;
}

- (void)addSubviews{
    [self addSubview:self.menuTableView];
}

- (void)addConstraints{
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
}

- (void)reloadData{
    if (self.lwSuperView&&self.lwTargetView) {
        [self layoutWithTargetView:self.lwTargetView inSuperView:self.lwSuperView];
    }
    [self.menuTableView reloadData];
}

- (void)layoutWithTargetView:(UIView *)targetView inSuperView:(UIView *)superView {
    self.lwTargetView = targetView;
    self.lwSuperView = superView;
    NSLog(@"%@",self.lwSuperView);
    CGRect targetViewFrameInSuperView = CGRectZero;
    targetViewFrameInSuperView = [targetView convertRect:targetView.bounds toView:superView];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lwSuperView);
        make.right.equalTo(self.lwSuperView);
    make.top.equalTo(self.lwSuperView).offset(targetViewFrameInSuperView.origin.y+targetViewFrameInSuperView.size.height);
        make.height.mas_equalTo([self coculateHeight]);
    }];
}

- (CGFloat )coculateHeight{
    CGFloat height = 0;
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuShowArray)]) {
        if ([self.dataSource respondsToSelector:@selector(LWTextFieldMenuItemHeight)]) {
            height = self.dataSource.LWTextFieldMenuItemHeight*self.dataSource.LWTextFieldMenuShowArray.count;
        }else{
            height = 30*self.dataSource.LWTextFieldMenuShowArray.count;
        }
    }else{
        height = 0;
    }
    
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuMaxHeight)]) {
        if (height>self.dataSource.LWTextFieldMenuMaxHeight) {
            height = self.dataSource.LWTextFieldMenuMaxHeight;
        }
    }else{
        if (height>200) {
            height = 200;
        }
    }
    return height;
}


//tableVIewSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuShowArray)]) {
        return self.dataSource.LWTextFieldMenuShowArray.count;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuItemHeight)]) {
        return self.dataSource.LWTextFieldMenuItemHeight;
    }else{
        return 30;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWTextFieldMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLWTextFieldMenuTableViewCell forIndexPath:indexPath];
    cell.itemLabel.text = self.dataSource.LWTextFieldMenuShowArray[indexPath.row];
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuItemTitleFont)]) {
        cell.itemLabel.font = self.dataSource.LWTextFieldMenuItemTitleFont;
    }
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuItemTitleColor)]) {
        cell.itemLabel.textColor = self.dataSource.LWTextFieldMenuItemTitleColor;
    }
    cell.deleteButton.tag = indexPath.row;
    if (self.dataSource&&[self.dataSource respondsToSelector:@selector(LWTextFieldMenuItemDeleteButtonImage)]) {
        [cell.deleteButton setImage:self.dataSource.LWTextFieldMenuItemDeleteButtonImage forState:UIControlStateNormal];
    }
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)deleteButtonClicked:(UIButton *)deleteButton{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(LWTextFieldMenuItemDeleted:)]) {
        [self.delegate LWTextFieldMenuItemDeleted:deleteButton.tag];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //执行代理
    if (self.delegate&&[self.delegate respondsToSelector:@selector(LWTextFieldMenuItemSelected:)]) {
        [self.delegate LWTextFieldMenuItemSelected:indexPath.row];
    }
}

- (UITableView *)menuTableView{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] init];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.backgroundColor = [UIColor whiteColor];
        [_menuTableView registerClass:[LWTextFieldMenuTableViewCell class] forCellReuseIdentifier:kLWTextFieldMenuTableViewCell];
    }
    return _menuTableView;
}

- (void)showWithAnimation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.hidden = NO;
        }];
    }else{
        self.hidden = NO;
    }
}
- (void)hidWithAnimation:(BOOL)animation{
    if (self) {
        [UIView animateWithDuration:0.5 animations:^{
            self.hidden = YES;
        }];
    }else{
        self.hidden = YES;
    }
}
@end
