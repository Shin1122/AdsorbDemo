//
//  MeiTuanDemo.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/13.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "MeiTuanDemo.h"
#import "MeiTuanHeader.h"

@interface MeiTuanDemo (){
    
    MeiTuanHeader *_header;
}

@end

@implementation MeiTuanDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    _header = [[MeiTuanHeader alloc]init];
    [self.view addSubview:_header];
    _header.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(200);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
