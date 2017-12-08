//
//  ChildVC3.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ChildVC3.h"

@interface ChildVC3 ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UICollectionViewFlowLayout *_layout;
    
}

@end

@implementation ChildVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(self.view.width_sd/3-40, self.view.width_sd/3-40) ;
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 10;
    _mainView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    [self.view addSubview:_mainView];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    _mainView.delegate = self;
    _mainView.dataSource = self;
    
    /* collectionView 注册cell、headerID、footerId*/
    [_mainView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    self.leadingViewState = LeadingViewStateUnfold;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 40;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"cellId";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:0.0 green:0.63 blue:0.78 alpha:1.0];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(20, 40, 20, 40);
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
