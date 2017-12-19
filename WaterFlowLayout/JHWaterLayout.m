//
//  JHWaterLayout.m
//  mm
//
//  Created by yunjinghui on 2017/11/23.
//  Copyright © 2017年 jinghui. All rights reserved.
//

#import "JHWaterLayout.h"

static const NSInteger DefaultColumnCount = 3;
// 每一列之间的间距
static const CGFloat DefaultColumnMargin = 10;
// 每一行之间的间距
static const CGFloat DefaultRowMargin = 10;

static const UIEdgeInsets DefaultEdgeInsets = {10, 10, 10, 10};

@interface JHWaterLayout()

/**
 存放所有布局属性
 */
@property (nonatomic, strong) NSMutableArray *attrsArray;

/**
 存放所有列的高度
 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)getRowMargin;
- (CGFloat)getColumnMargin;
- (UIEdgeInsets)getEdgeInsets;
- (CGFloat)getColumnCount;

@end

@implementation JHWaterLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.contentHeight = 0;
    
    // 初始化行数组
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.getColumnCount; i++) {
        [self.columnHeights addObject:@(self.getEdgeInsets.top)];
    }
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        // 创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // 获取indexPath  cell位置对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

// 决定排布
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}

// 决定返回indexPathcell对应属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    // collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    CGFloat w = (collectionViewW - self.getEdgeInsets.left - self.getEdgeInsets.right - (self.getColumnCount - 1) * self.getColumnMargin) / self.getColumnCount;
    CGFloat h = [self.delegate waterFlowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // 找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.getColumnCount; i++) {
        // 取出第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (columnHeight < minColumnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.getEdgeInsets.left + destColumn * (w + self.getColumnMargin);
    CGFloat y = minColumnHeight;
    // 第一行显示的高度是DefaultEdgeInsets.top
    if (y != self.getEdgeInsets.top) {
        y += [self getRowMargin];
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短的那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    
    // 记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight) {
        self.contentHeight = columnHeight;
    }

    return attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.getEdgeInsets.bottom);
}

#pragma mark - getter
- (CGFloat)getRowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)]) {
        return [self.delegate rowMarginInWaterflowLayout:self];
    } else {
        return DefaultRowMargin;
    }
}

- (CGFloat)getColumnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    } else {
        return DefaultColumnMargin;
    }
}

- (UIEdgeInsets)getEdgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowLayout:self];
    } else {
        return DefaultEdgeInsets;
    }
}

- (CGFloat)getColumnCount {
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        return [self.delegate columnCountInWaterFlowLayout:self];
    } else {
        return DefaultColumnCount;
    }
}

- (NSMutableArray *)attrsArray {
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (NSMutableArray *)columnHeights {
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

@end
