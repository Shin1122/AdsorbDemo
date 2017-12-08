//
//  HMSegmentedControl+Category.m
//  Qatime_Teacher
//
//  Created by Shin on 2017/7/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "HMSegmentedControl+Category.h"

@implementation HMSegmentedControl (Category)

+ (instancetype)segmentControlWithTitles:(NSArray *)titles{
    
    HMSegmentedControl *_segmentControl;
    
    _segmentControl  = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    _segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName:TITLECOLOR,NSFontAttributeName:TEXT_FONTSIZE};
    _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:TEXT_FONTSIZE};
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorColor = BUTTONRED;
    _segmentControl.selectionIndicatorHeight = 2;
    _segmentControl.borderType = HMSegmentedControlBorderTypeBottom;
    _segmentControl.borderColor = TITLECOLOR;
    _segmentControl.borderWidth = 0.5;
    
    return _segmentControl;
}


@end
