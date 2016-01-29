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

#pragma mark - 控制器视图加载
/**
 *  控制器视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置文本框的值改变事件
    [self setupTextFieldValueChangedAction];
    
    // 文本框值改变事件处理
    [self textFieldValueChangedAction:nil];
}

/**
 *  控制器视图显示完成
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 设置用户名为第一响应者
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

#pragma mark - 子控件事件处理
/**
 *  创建联系人按钮点击事件
 */
- (IBAction)createButtonClickAction:(id)sender {
    // 1.返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.创建联系人信息
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[@"userName"] = self.userNameTextField.text;
    dictionary[@"phoneNum"] = self.phoneNumTextField.text;
    
    AddressBookModel *addressBook = [[AddressBookModel alloc] initAddressBookWithDictionary:dictionary];
    
    // 3.判断是否需要调用代理方法
    if ([self.delegate respondsToSelector:@selector(addressBookCreateViewController:addressBook:)]) {
        [self.delegate addressBookCreateViewController:self addressBook:addressBook];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
