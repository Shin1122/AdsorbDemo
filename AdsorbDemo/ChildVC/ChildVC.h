//
//  ChildVC.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Base_ChildVC */

/**
 顶部视图的折叠/展开状态
 
 - LeadingViewStateFold: 折叠
 - LeadingViewStateUnfold: 展开
 */
typedef NS_ENUM(NSUInteger, LeadingViewState) {
    LeadingViewStateFold,
    LeadingViewStateUnfold,
};
@interface ChildVC : UIViewController

/** 记录header的状态的变量 */
@property (nonatomic, assign)LeadingViewState leadingViewState ;

@end
