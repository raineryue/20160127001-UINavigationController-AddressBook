//
//  AddressBookEditViewController.h
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressBookEditViewController, AddressBookModel;

@protocol AddressBookEditViewControllerDelegate <NSObject>

@optional
- (void)addressBookEditViewController:(AddressBookEditViewController *)viewController addressBook:(AddressBookModel *)addressBook;

@end

@interface AddressBookEditViewController : UIViewController

@property (nonatomic, strong) AddressBookModel *addressBook;

@property (nonatomic, weak) id<AddressBookEditViewControllerDelegate> delegate;

@end
