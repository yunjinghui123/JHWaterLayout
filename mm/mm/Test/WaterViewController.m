//
//  WaterViewController.m
//  mm
//
//  Created by yunjinghui on 2017/11/23.
//  Copyright © 2017年 jinghui. All rights reserved.
//

#import "WaterViewController.h"


@interface WaterViewController () <JHWaterLayoutDelegate>
@property (weak, nonatomic) IBOutlet JHWaterLayout *waterFlow;

@end

@implementation WaterViewController

static NSString * const reuseIdentifier = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    JHWaterLayout *layout = [[JHWaterLayout alloc] init];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.waterFlow.delegate = self;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"TestCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGFloat)waterFlowLayout:(JHWaterLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    return 50 + arc4random_uniform(300);
}


#pragma mark - JHWaterLayoutDelegate

- (CGFloat)rowMarginInWaterflowLayout:(JHWaterLayout *)waterflowLayout {
    return 20;
}


@end
