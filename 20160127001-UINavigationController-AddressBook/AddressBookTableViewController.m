//
//  AddressBookTableViewController.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookTableViewController.h"
#import "AddressBookModel.h"
#import "AddressBookCreateViewController.h"
#import "AddressBookEditViewController.h"
#import "AddressBookTableViewCell.h"

#define kDataPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"addressBook.data"]

@interface AddressBookTableViewController () <AddressBookCreateViewControllerDelegate, AddressBookEditViewControllerDelegate>

/** 联系人列表数据 */
@property (nonatomic, strong) NSMutableArray *addressBookArray;

@end

@implementation AddressBookTableViewController

#pragma mark - 控制器视图加载
/**
 *  控制器视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置当前表的表格行的分割线（设置为没有分割线）
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加按钮获取
    UIBarButtonItem *addBarButtonItem = self.navigationItem.rightBarButtonItem;
    // 编辑按钮创建
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editBarButtonItemClickAction:)];
    
    // 添加导航栏右边按钮
    self.navigationItem.rightBarButtonItems = @[addBarButtonItem, editBarButtonItem];
}

#pragma mark - 表格数据源代理方法
/**
 *  返回表格每组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressBookArray.count;
}

/**
 *  返回表格的每行的表格行
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建自定义的表格行
    AddressBookTableViewCell *cell = [AddressBookTableViewCell addressBookTableViewCellWithTableView:tableView];

    // 2.设置表格行的数据信息
    cell.addressBook = self.addressBookArray[indexPath.row];
    
    // 3.返回表格行
    return cell;
}

/**
 *  返回编辑表格行的编辑样式
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.addressBookArray.count - 1)
        return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
}

/**
 *  提交编辑表格行
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete == editingStyle) { // 删除操作
        [self.addressBookArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    } else { // 新增操作
        // 模拟一个联系人信息
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        dictionary[@"userName"] = @"测试人员";
        dictionary[@"phoneNum"] = @"18818888888";
        
        AddressBookModel *addressBook = [AddressBookModel addressBookWithDictionary:dictionary];
        
        // 将联系人信息添加到联系人列表中
        [self.addressBookArray addObject:addressBook];
        
        // 创建一个indexPath
        NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        // 添加一个新的表格行到表格上
        [tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    
    // 数据归档
    [NSKeyedArchiver archiveRootObject:self.addressBookArray toFile:kDataPath];
}

#pragma mark - 代理方法
/**
 *  添加联系人代理方法
 */
- (void)addressBookCreateViewController:(AddressBookCreateViewController *)viewController addressBook:(AddressBookModel *)addressBook {
    // 将最新联系人数组赋值给当前数组
    [self.addressBookArray addObject:addressBook];
    
    // 刷新表格
    [self.tableView reloadData];
    
    // 数据归档
    [NSKeyedArchiver archiveRootObject:self.addressBookArray toFile:kDataPath];
}

/**
 *  修改联系人代理方法
 */
- (void)addressBookEditViewController:(AddressBookEditViewController *)viewController addressBook:(AddressBookModel *)addressBook {
    // 刷新表格
    [self.tableView reloadData];
    
    // 数据归档
    [NSKeyedArchiver archiveRootObject:self.addressBookArray toFile:kDataPath];
}

#pragma mark - 控制器跳转事件
/**
 *  UISegue跳转前调用
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 判断跳转的目标控制器类型，并作相关的操作
    if ([segue.destinationViewController isKindOfClass:[AddressBookCreateViewController class]]) {
        // 添加联系人控制器
        AddressBookCreateViewController *addressBookCreateCiewController = segue.destinationViewController;
        
        addressBookCreateCiewController.delegate = self;
    } else {
        // 修改联系人控制器
        AddressBookEditViewController *addressBookEditViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        addressBookEditViewController.addressBook = self.addressBookArray[indexPath.row];
        
        addressBookEditViewController.delegate = self;
    }
}

#pragma mark - 子控件事件处理
/**
 *  注销按钮点击事件
 */
- (IBAction)logoutButtonClickAction:(id)sender {
    // 1.创建提示框控件
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否要退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 2.添加注销按钮并添加事件
    [alertController addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    // 3.添加取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 4.显示提示框按钮
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  编辑按钮点击事件
 */
- (void)editBarButtonItemClickAction:(UIBarButtonItem *)barButtonItem {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

#pragma mark - 属性懒加载
/**
 *  联系人数组信息
 */
- (NSMutableArray *)addressBookArray {
    if (nil == _addressBookArray) {
        _addressBookArray = [NSKeyedUnarchiver unarchiveObjectWithFile:kDataPath];
        
        if (nil == _addressBookArray) {
            _addressBookArray = [NSMutableArray array];
        }
    }
    
    return _addressBookArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
