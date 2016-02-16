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

#pragma mark - 控制器视图加载
/**
 *  控制器视图完成加载
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取本地登录帐号自动登录
    [self autoLoginMemberDefaultUser];
    
    // 监听文本框值改变事件
    [self monitorTextFieldAction];
    
    // 自动调用文本框值改变事件
    [self textFieldValueChangedAction:nil];
}

/**
 *  监听文本框值改变事件
 */
- (void)monitorTextFieldAction {
    // 登录文本框值改变事件监听
    [self.loginNameTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];

    // 密码文本框值改变事件监听
    [self.passwordTextField addTarget:self action:@selector(textFieldValueChangedAction:) forControlEvents:UIControlEventEditingChanged];
}

/**
 *  自动调用文本框值改变事件
 */
- (void)textFieldValueChangedAction:(UITextField *)textField {
    // 判断文本框是否都有值，如有值则改变按钮的状态和颜色（可点击）
    if (self.loginNameTextField.text.length && self.passwordTextField.text.length) {
        self.loginButton.enabled = YES;
        self.loginButton.backgroundColor = [UIColor orangeColor];
    } else {
        self.loginButton.enabled = NO;
        self.loginButton.backgroundColor = [UIColor lightGrayColor];
    }
}

/**
 *  获取本地登录帐号自动登录
 */
- (void)autoLoginMemberDefaultUser {
    // 创建偏好设置对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 从沙盒中获取已存储的信息并赋值到界面上
    // 登录帐号文本框
    self.loginNameTextField.text = [userDefaults objectForKey:@"loginName"];
    
    // 记住账号开关
    self.memberSwitch.on = [userDefaults boolForKey:@"memberPassword"];
    
    // 当记住账号开关打开时需要复制密码
    if (self.memberSwitch.on) {
        // 密码文本框
        self.passwordTextField.text = [userDefaults objectForKey:@"password"];
    }
    
    // 自动登录开关
    self.autoLoginSwitch.on = [userDefaults boolForKey:@"autoLogin"];
    
    // 当自动登录开关打开时手动调用登录按钮点击事件
    if (self.autoLoginSwitch.on) {
        [self loginButtonClickAction:nil];
    }
}

#pragma mark - 子视图控件处理事件
/**
 *  记住密码控件事件监听
 */
- (IBAction)memberSwitchClickAction:(UISwitch *)switcher {
    if (!switcher.isOn) {
        self.autoLoginSwitch.on = NO;
    }
}

/**
 *  自动登录控件事件监听
 */
- (IBAction)autoLoginSwitchClickAction:(UISwitch *)switcher {
    if (switcher.isOn) {
        self.memberSwitch.on = YES;
    }
}

/**
 *  登录按钮控件事件监听
 */
- (IBAction)loginButtonClickAction:(id)sender {
    // 添加提示框
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // 判断文本框时候均有值如有值则登录
    if ([self.loginNameTextField.text isEqualToString:@"Rainer"] && [self.passwordTextField.text isEqualToString:@"123456"]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // 延迟调用登录跳转方法
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"loginToList" sender:nil];
            
            // 创建偏好设置对象
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            // 将登录信息存入偏好设置对象中
            [userDefaults setObject:self.loginNameTextField.text forKey:@"loginName"];
            [userDefaults setObject:self.passwordTextField.text forKey:@"password"];
            [userDefaults setBool:self.memberSwitch.isOn forKey:@"memberPassword"];
            [userDefaults setBool:self.autoLoginSwitch.isOn forKey:@"autoLogin"];
            
            // 将内存中的对象信息存入沙盒中
            [userDefaults synchronize];
        });
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

#pragma mark - 导航栏控制器事件
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
