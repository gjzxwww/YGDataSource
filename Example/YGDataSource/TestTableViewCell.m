//
//  TestTableViewCell.m
//  YGDataSource_Example
//
//  Created by wyg on 2020/8/5.
//  Copyright © 2020 wyg. All rights reserved.
//

#import "TestTableViewCell.h"


@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUI];
    }
    
    return self;
}

-(void)setUI
{
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
    [self.contentView addSubview:name];
    self.nameLabel = name;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 100, 44)];
    [self.contentView addSubview:title];
    self.titleLab = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
