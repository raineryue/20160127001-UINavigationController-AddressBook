//
//  AddressBookCreateViewController.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookCreateViewController.h"
#import "AddressBookModel.h"

@interface AddressBookCreateViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation AddressBookCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置文本框的值改变事件
    [self setupTextFieldValueChangedAction];
    
    // 文本框值改变事件处理
    [self textFieldValueChangedAction:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.userNameTextField becomeFirstResponder];
}

/**
 *  设置文本框的值改变事件
 */
- (void)setupTextFieldValueChangedAction {
    [self.userNameTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];
}

/**
 *  文本框值改变事件处理
 */
- (void)textFieldValueChangedAction:(UITextField *)textField {
    if (self.userNameTextField.text.length && self.phoneNumTextField.text.length) {
        self.createButton.enabled = YES;
        self.createButton.backgroundColor = [UIColor orangeColor];
    }
}

- (IBAction)createButtonClickAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"userName"] = self.userNameTextField.text;
    dictionary[@"phoneNum"] = self.phoneNumTextField.text;
    
    AddressBookModel *addressBook = [[AddressBookModel alloc] initAddressBookWithDictionary:dictionary];
    
    if ([self.delegate respondsToSelector:@selector(addressBookCreateViewController:addressBook:)]) {
        [self.delegate addressBookCreateViewController:self addressBook:addressBook];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
