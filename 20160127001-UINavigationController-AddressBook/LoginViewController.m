//
//  LoginViewController.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/27.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"

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
    
    [self textFieldValueChangedAction:nil];
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
    MBProgressHUD *progress = [[MBProgressHUD alloc] init];
    
    [progress show:YES];
    
    if ([self.loginNameTextField.text isEqualToString:@"Rainer"] && [self.passwordTextField.text isEqualToString:@"123456"]) {
        [progress hide:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"loginToList" sender:nil];
        });
    } else {
        [progress hide:YES];
    }
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
