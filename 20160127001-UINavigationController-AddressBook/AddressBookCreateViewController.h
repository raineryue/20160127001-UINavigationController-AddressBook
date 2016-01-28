//
//  AddressBookCreateViewController.h
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressBookCreateViewController, AddressBookModel;

@protocol AddressBookCreateViewControllerDelegate <NSObject>

@optional
- (void)addressBookCreateViewController:(AddressBookCreateViewController *)viewController addressBook:(AddressBookModel *)addressBook;

@end

@interface AddressBookCreateViewController : UIViewController

@property (nonatomic, weak) id<AddressBookCreateViewControllerDelegate> delegate;

@end
