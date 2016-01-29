//
//  AddressBookTableViewCell.h
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/29.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressBookModel;

@interface AddressBookTableViewCell : UITableViewCell

/** 联系人模型 */
@property (nonatomic, strong) AddressBookModel *addressBook;

/**
 *  根据TableView初始化一个TableViewCell
 */
- (instancetype)initAddressBookTableViewCellWithTableView:(UITableView *)tableView;

/**
 *  根据TableView初始化一个TableViewCell
 */
+ (instancetype)addressBookTableViewCellWithTableView:(UITableView *)tableView;

@end
