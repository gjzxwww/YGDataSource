//
//  YGDataSource.m
//
//  Created by wyg on 2020/8/5.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import "YGDataSource.h"


@interface YGDataSource ()

@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;

@property (nonatomic, copy)   selectCell selectBlock;

@end

@implementation YGDataSource

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before  selectBlock:(selectCell)selectBlock{
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock = [selectBlock copy];
       
    }
    return self;
}


- (void)addDataArray:(NSArray *)datas{
    if(!datas) return;
    
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }

    [self.dataArray addObjectsFromArray:datas];
    
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}



#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return !self.dataArray  ? 0: self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    
    return cell;
}


#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return !self.dataArray  ? 0: self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }

    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
     id model = [self modelsAtIndexPath:indexPath];
    self.selectBlock( model,indexPath);
}

#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 将点击事件通过block的方式传递出去
     id model = [self modelsAtIndexPath:indexPath];
    self.selectBlock(model, indexPath);
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
    
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return YES;
//   
//}
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    __weak __typeof(self) weakSelf = self;
//    // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        //在这里添加点击事件
//        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
//        weakSelf.reloadData(weakSelf.dataArray);
//        NSLog(@"shanchu");
//    }];
////    // 添加一个编辑按钮
////    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"复制"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
////        //
////
////        //在这里添加点击事件
////        [weakSelf.dataArray insertObject:weakSelf.dataArray[indexPath.row] atIndex:indexPath.row];
////        weakSelf.reloadData(weakSelf.dataArray);
////    }];
////    topRowAction.backgroundColor = [UIColor cyanColor];
//    // 将设置好的按钮放到数组中返回
//    return @[deleteRowAction];
//}

@end
