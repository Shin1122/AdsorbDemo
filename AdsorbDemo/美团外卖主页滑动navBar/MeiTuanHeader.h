//
//  MeiTuanHeader.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeiTuanNavBar.h"
#import "SDCycleScrollView.h"

/**
 页面结构分析:
 header中的列表布局,有一个banner,一个collectionMenu 和一个collectionview.
 我们可以将collection分为3个section来处理,把delegate和datasource全都放在MeiTuanDemo中处理.
 给定的高度计算一定要"严丝合缝".
 这里可以使用SDAutoLayout的高度自动计算功能,通过runtime来自动获取高度.
 */

@interface MeiTuanHeader : UIView

@property (nonatomic, strong) MeiTuanNavBar *navBar ;

@property (nonatomic, strong) SDCycleScrollView *banner ;

@property (nonatomic, strong) UICollectionView *collectionMenu ;
@end
