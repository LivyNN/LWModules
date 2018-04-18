//
//  LWFlowLayoutView.m
//  LWModules
//
//  Created by apple on 2018/3/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LWFlowLayoutView.h"
#import "LWFlowLayoutTableViewCell.h"
#import "Masonry.h"

@interface LWFlowLayoutView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong, readwrite)NSMutableArray<UIView *> *viewArray;
@property(nonatomic, strong, readwrite)NSMutableArray<NSNumber *> *heightArray;
@property(nonatomic, strong, readwrite)UITableView *contentTableView;

@end

@implementation LWFlowLayoutView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubViews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.contentTableView];
}

- (void)addConstraints{
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(self);
    }];
}

#pragma mark -private
- (void)lw_InsertSubView:(UIView *)view height:(CGFloat)viewHeight{
    if (![self.viewArray containsObject:view]) {
        [self.viewArray addObject:view];
        [self.heightArray addObject:@(viewHeight)];
        /*是否需要刷新*/
    }
}

- (void)lw_RemoveSubViewAtRow:(NSInteger)row{
    if(self.viewArray.count>row&&self.heightArray.count>row){
        [self.viewArray removeObjectAtIndex:row];
        [self.heightArray removeObjectAtIndex:row];
    }
}

- (void)lw_RemoveSubView:(UIView *)view{
    if ([self.viewArray containsObject:view]) {
        [self.heightArray removeObjectAtIndex:[self.viewArray indexOfObject:view]];
        [self.viewArray removeObject:view];
    }
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.heightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWFlowLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLWFlowLayoutTableViewCell forIndexPath:indexPath];
    if (self.viewArray[indexPath.row]&&(![cell.contentView.subviews containsObject:self.viewArray[indexPath.row]])) {
        for (UIView* subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        [cell.contentView addSubview:self.viewArray[indexPath.row]];
        [self.viewArray[indexPath.row] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.and.bottom.equalTo(cell.contentView);
        }];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewArray.count;
}

#pragma mark - lazyLoad
- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] init];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        [_contentTableView registerClass:[LWFlowLayoutTableViewCell class] forCellReuseIdentifier:kLWFlowLayoutTableViewCell];
    }
    return _contentTableView;
}

- (NSMutableArray<UIView *> *)viewArray{
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}

- (NSMutableArray<NSNumber *> *)heightArray{
    if (!_heightArray) {
        _heightArray = [[NSMutableArray alloc] init];
    }
    return _heightArray;
}
#pragma mark-outSet

- (NSArray<UIView *> *)currentViewArray{
    return [self.viewArray copy];
}
- (NSArray<NSNumber *> *)currentViewHeightArray{
    return [self.heightArray copy];
}

@end
