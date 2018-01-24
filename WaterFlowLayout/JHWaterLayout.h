//
//  JHWaterLayout.h
//  mm
//
//  Created by yunjinghui on 2017/11/23.
//  Copyright © 2017年 jinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHWaterLayoutDelegate;

@interface JHWaterLayout : UICollectionViewLayout
@property (nonatomic, weak) id<JHWaterLayoutDelegate> delegate;
@end

@protocol JHWaterLayoutDelegate <NSObject>

@required
/**
 传给布局的高度

 @param waterflowLayout waterLayout对象
 @param index item的位置
 @param itemWidth 每一个item的宽度
 @return item的高度
 */
- (CGFloat)waterFlowLayout:(JHWaterLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterFlowLayout:(JHWaterLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterFlowLayout:(JHWaterLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(JHWaterLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(JHWaterLayout *)waterflowLayout;

@end
