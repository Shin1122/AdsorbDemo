//
//  ChildVC1.m
//  AdsorbDemo
//
//  Created by Shin on 2017/12/9.
//  Copyright © 2017年 Shin. All rights reserved.
//

#import "ChildVC1.h"


@interface ChildVC1 ()<UITableViewDelegate ,UITableViewDataSource>{
    
}

@end

@implementation ChildVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_mainView];
    _mainView.allowsSelection = NO;
    _mainView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    _mainView.delegate = self;
    _mainView.dataSource = self;
    
    self.leadingViewState = LeadingViewStateUnfold;
    
    UIView *head = [[UIView alloc]init];
    head.frame = CGRectMake(0, 0, self.view.width_sd, 20);
    head.backgroundColor = [UIColor lightGrayColor];
    _mainView.tableHeaderView = head;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdenfier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 组数据",(long)indexPath.row];
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return  cell;
    
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
