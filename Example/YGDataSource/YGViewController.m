//
//  YGViewController.m
//  YGDataSource
//
//  Created by wyg on 08/05/2020.
//  Copyright (c) 2020 wyg. All rights reserved.
//

#import "YGViewController.h"
#import <YGDataSource/YGDataSource.h>
#import "TestTableViewCell.h"
#import "TestModel.h"

static NSString *const reuserId = @"reuserId";

@interface YGViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YGDataSource *dataSource;
@end

@implementation YGViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[TestTableViewCell class] forCellReuseIdentifier:reuserId];
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
	
    self.dataSource = [[YGDataSource alloc] initWithIdentifier:reuserId configureBlock:^(TestTableViewCell *cell, TestModel *model, NSIndexPath * _Nonnull indexPath)
    {
        cell.nameLabel.text = model.name;
        cell.titleLab.text = model.title;
        
        
    } selectBlock:^( TestModel *model ,NSIndexPath * _Nonnull indexPath)
    {
        NSLog(@"点了第%ld行%@",indexPath.row,model.name);
    }];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
    NSArray *arr = @[
    @{@"name":@"张三",@"title":@"111"},
    @{@"name":@"李四",@"title":@"222"},
    @{@"name":@"王五",@"title":@"333"}];
    
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:3];
    
    for (int i = 0; i<arr.count; i++)
    {
        TestModel *model = [[TestModel alloc] init];
        model.name = arr[i][@"name"];
        model.title = arr[i][@"title"];
        [mutArr addObject:model];
    }
    
    [self.dataSource addDataArray:mutArr];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
