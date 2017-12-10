//
//  UITableView+Guesture.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/10.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "UITableView+Guesture.h"

@implementation UITableView (Guesture)
//允许同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
