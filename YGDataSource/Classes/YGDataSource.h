//
//  YGDataSource.h
//
//  Created by wyg on 2020/8/5.
//  Copyright © 2020 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
typedef void (^selectCell) (id model,NSIndexPath *indexPath);

@interface YGDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource,UITableViewDelegate,UICollectionViewDelegate>

@property (nonatomic, strong)  NSMutableArray *dataArray;;

//自定义
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock;


- (void)addDataArray:(NSArray *)datas;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
