//
//  BoutiqueScrollView.h
//  FoodFamily
//
//  Created by tam on 2017/11/4.
//  Copyright © 2017年 Wilkinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoutiqueScrollDelegate <NSObject>
- (void)boutiqueScrollChoose:(NSInteger)index;
@end

@interface BoutiqueScrollView : UIView
//- (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,assign) id<BoutiqueScrollDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;
@end
