//
//  HMSegmentedControl+Category.m
//  Qatime_Teacher
//
//  Created by Shin on 2017/7/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "HMSegmentedControl+Category.h"
#import <objc/runtime.h>

static const void *meanScrollViewKey = &meanScrollViewKey;

@implementation HMSegmentedControl (Category)

-(void)setMeanScrollView:(UIScrollView *)meanScrollView{
    
    objc_setAssociatedObject(self, meanScrollViewKey, meanScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIScrollView *)meanScrollView{
    return  objc_getAssociatedObject(self, meanScrollViewKey);
}



+ (instancetype)segmentControlWithTitles:(NSArray *)titles{
    
    __block HMSegmentedControl *_segmentControl;
    _segmentControl  = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    _segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:13]};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorColor = [UIColor redColor];
    _segmentControl.selectionIndicatorHeight = 2;
    _segmentControl.borderType = HMSegmentedControlBorderTypeBottom;
    _segmentControl.borderColor = [UIColor redColor];
    _segmentControl.borderWidth = 0.5;
    
    _segmentControl.indexChangeBlock = ^(NSInteger index) {
        if (_segmentControl.meanScrollView) {
            [_segmentControl.meanScrollView scrollRectToVisible:CGRectMake(index *_segmentControl.meanScrollView.width_sd, 0, _segmentControl.meanScrollView.width_sd, _segmentControl.meanScrollView.height_sd) animated:YES];
        }
    };
    
    return _segmentControl;
}


@end
