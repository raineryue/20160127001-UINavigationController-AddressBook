//
//  AddressBookEditViewController.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookEditViewController.h"
#import "AddressBookModel.h"

@interface AddressBookEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UIButton *makeSureButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;

@end

@implementation AddressBookEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTextFieldValues];
    
    // 设置文本框的值改变事件
    [self setupTextFieldValueChangedAction];
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
        self.makeSureButton.enabled = YES;
        self.makeSureButton.backgroundColor = [UIColor orangeColor];
    } else {
        self.makeSureButton.enabled = NO;
        self.makeSureButton.backgroundColor = [UIColor lightGrayColor];
    }
}

- (IBAction)editBarButtonItemClickAction:(UIBarButtonItem *)barButtonItem {
    if ([barButtonItem.title isEqualToString:@"编辑"]) {
        self.userNameTextField.enabled = YES;
        self.phoneNumTextField.enabled = YES;
        self.makeSureButton.hidden = NO;
        self.makeSureButton.enabled = YES;
        self.makeSureButton.backgroundColor = [UIColor orangeColor];
        barButtonItem.title = @"取消";
        
        [self.phoneNumTextField becomeFirstResponder];
    } else {
        self.userNameTextField.enabled = NO;
        self.phoneNumTextField.enabled = NO;
        self.makeSureButton.hidden = YES;
        self.makeSureButton.enabled = NO;
        self.makeSureButton.backgroundColor = [UIColor lightGrayColor];
        barButtonItem.title = @"编辑";
        
        [self setupTextFieldValues];
        
        [self touchesEnded:nil withEvent:nil];
    }
}

- (void)setupTextFieldValues {
    self.userNameTextField.text = self.addressBook.userName;
    self.phoneNumTextField.text = self.addressBook.phoneNum;
}

- (IBAction)makeSureButtonClickAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    self.addressBook.userName = self.userNameTextField.text;
    self.addressBook.phoneNum = self.phoneNumTextField.text;
    
    if ([self.delegate respondsToSelector:@selector(addressBookEditViewController:addressBook:)]) {
        [self.delegate addressBookEditViewController:self addressBook:self.addressBook];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
