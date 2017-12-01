//
//  BoutiqueScrollView.m
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import "BoutiqueScrollView.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "TYCyclePagerViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define XMAKE(x) (x) * [UIScreen mainScreen].bounds.size.width / 375
#define YMAKE(y) (y) * [UIScreen mainScreen].bounds.size.height / 667
@interface BoutiqueScrollView () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation BoutiqueScrollView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        self.datas = dataArray;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    [self addPagerView];
    [self loadData];
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
//    pagerView.layer.borderWidth = 1;
    pagerView.autoScrollInterval = 0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    pagerView.isInfiniteLoop = NO;
    [pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:pagerView];
    _pagerView = pagerView;
    
    _pagerView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)loadData {
//    NSMutableArray *datas = [NSMutableArray array];
//    for (int i = 0; i < 7; ++i) {
//        if (i == 0) {
//            [datas addObject:[UIColor redColor]];
//            continue;
//        }
//        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
//    }
//    _datas = [datas copy];
//    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_datas[index]] placeholderImage:[UIImage imageNamed:@"ic_xt_portrait"]];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(XMAKE(330), self.frame.size.height);
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(boutiqueScrollChoose:)]) {
        [self.delegate boutiqueScrollChoose:index];
    }
}

-(NSArray *)datas{
    if (_datas == nil) {
        _datas = [[NSArray alloc] init];
    }
    return _datas;
}

@end
