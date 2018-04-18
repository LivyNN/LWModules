//
//  LWSegmentView.h
//  LWModules
//
//  Created by apple on 2018/4/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


//这个SegmentView是Label表现的，如果是其他形式可以参考这个封装。
@interface LWSegmentView : UIView

@property(nonatomic, assign, readonly)NSInteger selectedItem;

@property(nonatomic, strong)UIColor *slipViewColor;

@property(nonatomic, assign)float cellWidth;

@property(nonatomic, assign)float slipAnimationTime;

@property(nonatomic, strong)NSArray<id> *sourceArr;

- (void)customCellBlock:(void (^)(UILabel *label, id customObj, NSInteger index))customBlock;
- (void)customSelectedBlock:(void (^)(UILabel *label, id customObj, NSInteger orgIndex, NSInteger curIndex))selectedBlock;
- (void)customDeselectedBLock:(void (^)(UILabel *label, id customObj,NSInteger index))deselectedBlock;
@end
