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

@interface AddressBookTableViewController () <AddressBookCreateViewControllerDelegate, AddressBookEditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *addressBookArray;

@end

@implementation AddressBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressBookArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCellIdentifier = @"addressBookTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier forIndexPath:indexPath];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:tableViewCellIdentifier];
    }
    
    AddressBookModel *addressBook = self.addressBookArray[indexPath.row];
    
    cell.textLabel.text = addressBook.userName;
    cell.detailTextLabel.text = addressBook.phoneNum;
    
    return cell;
}

- (void)addressBookCreateViewController:(AddressBookCreateViewController *)viewController addressBook:(AddressBookModel *)addressBook {
    NSMutableArray *addressBookList = [NSMutableArray arrayWithArray:self.addressBookArray];
    
    [addressBookList addObject:addressBook];
    
    self.addressBookArray = addressBookList;
    
    [self.tableView reloadData];
}

- (void)addressBookEditViewController:(AddressBookEditViewController *)viewController addressBook:(AddressBookModel *)addressBook {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[AddressBookCreateViewController class]]) {
        AddressBookCreateViewController *addressBookCreateCiewController = segue.destinationViewController;
        
        addressBookCreateCiewController.delegate = self;
    } else {
        AddressBookEditViewController *addressBookEditViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        addressBookEditViewController.addressBook = self.addressBookArray[indexPath.row];
        
        addressBookEditViewController.delegate = self;
    }
}

- (IBAction)logoutButtonClickAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否要退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSMutableArray *)addressBookArray {
    if (nil == _addressBookArray || 0 == _addressBookArray.count) {
        _addressBookArray = [NSMutableArray array];
        
        NSDictionary *dictionary = @{@"userName":@"Rainer", @"phoneNum":@"15022222222"};
        
        AddressBookModel *addressBook = [AddressBookModel addressBookWithDictionary:dictionary];
        
        [_addressBookArray addObject:addressBook];
    }
    
    return _addressBookArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
