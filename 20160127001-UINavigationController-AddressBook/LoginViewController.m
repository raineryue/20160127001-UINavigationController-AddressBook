//
//  LoginViewController.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/27.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *memberSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self monitorTextFieldAction];
}

- (void)monitorTextFieldAction {
    [self.loginNameTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];
    
    [self.passwordTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldValueChangedAction:(UITextField *)textField {
    if (self.loginNameTextField.text.length && self.passwordTextField.text.length) {
        self.loginButton.enabled = YES;
        self.loginButton.backgroundColor = [UIColor orangeColor];
    } else {
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = [UIColor lightGrayColor];
    }
}

- (IBAction)memberSwitchClickAction:(UISwitch *)switcher {
    if (!switcher.isOn) {
        self.autoLoginSwitch.on = NO;
    }
}

- (IBAction)autoLoginSwitchClickAction:(UISwitch *)switcher {
    if (switcher.isOn) {
        self.memberSwitch.on = YES;
    }
}

- (IBAction)loginButtonClickAction:(id)sender {
    [self performSegueWithIdentifier:@"loginToList" sender:nil];
}

#pragma mark - Navigation
/**
 *  在跳转前调用
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 获取目标控制器
    UIViewController *viewController = segue.destinationViewController;
    
    // 设置目标控制器的标题
    viewController.navigationItem.title = [NSString stringWithFormat:@"%@的通讯录列表", self.loginNameTextField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
