//
//  ChildVC5.h
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildVC5 : UITableViewController
//判断手指是否离开
@property (nonatomic, assign) BOOL isTouch;

@property (assign, nonatomic) BOOL canScroll;
@property(nonatomic,assign)BOOL isRefreshing;

@end
