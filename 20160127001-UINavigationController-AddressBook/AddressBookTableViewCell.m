//
//  AddressBookTableViewCell.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/29.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookTableViewCell.h"
#import "AddressBookModel.h"

@interface AddressBookTableViewCell ()

/** 声明表格行分割线视图 */
@property (nonatomic, weak) UIView *tableViewCellSeparator;

@end

@implementation AddressBookTableViewCell

/**
 *  根据TableView初始化一个TableViewCell
 */
- (instancetype)initAddressBookTableViewCellWithTableView:(UITableView *)tableView {
    // 1.定义一个静态变量作为TableViewCell标示
    static NSString *tableViewCellIdentifier = @"addressBookTableViewCellIdentifier";
    
    // 2.从tableView缓存中根据TableViewCell标示取出TableViewCell
    AddressBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    // 3.如果缓存中没有就根据TableViewCell标示创建一个TableViewCell
    if (nil == cell) {
        cell = [[AddressBookTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tableViewCellIdentifier];
    }
    
    // 4.返回创建好的TableViewCell
    return cell;
}

/**
 *  根据TableView初始化一个TableViewCell
 */
+ (instancetype)addressBookTableViewCellWithTableView:(UITableView *)tableView {
    return [[AddressBookTableViewCell alloc] initAddressBookTableViewCellWithTableView:tableView];
}

/**
 *  复写addressBook的setter方法，设置当前表格行的信息
 */
- (void)setAddressBook:(AddressBookModel *)addressBook {
    _addressBook = addressBook;
    
    self.textLabel.text = addressBook.userName;
    self.detailTextLabel.text = addressBook.phoneNum;
}

/**
 *  懒加载创建表格行分割线
 */
- (UIView *)tableViewCellSeparator {
    if (nil == _tableViewCellSeparator) {
        // 创建一个分割线视图
        UIView *tableViewCellSeparator = [[UIView alloc] init];
        
        // 设置分割线视图的背景色和颜色清淡
        tableViewCellSeparator.backgroundColor = [UIColor blackColor];
        tableViewCellSeparator.alpha = 0.2f;
        
        // 赋值
        _tableViewCellSeparator = tableViewCellSeparator;
        
        // 将分割线视图添加到表格行的内容视图上
        [self.contentView addSubview:_tableViewCellSeparator];
    }
    
    return _tableViewCellSeparator;
}

/**
 *  布局子视图
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 获取子视图的frame坐标
    CGFloat tableViewCellSeparatorW = self.bounds.size.width;
    CGFloat tableViewCellSeparatorH = 1;
    CGFloat tableViewCellSeparatorX = 0;
    CGFloat tableViewCellSeparatorY = self.bounds.size.height - tableViewCellSeparatorH;
    
    self.tableViewCellSeparator.frame = CGRectMake(tableViewCellSeparatorX, tableViewCellSeparatorY, tableViewCellSeparatorW, tableViewCellSeparatorH);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
