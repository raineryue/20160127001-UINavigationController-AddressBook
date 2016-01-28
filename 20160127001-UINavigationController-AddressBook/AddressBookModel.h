//
//  AddressBookModel.h
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phoneNum;

- (instancetype)initAddressBookWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)addressBookWithDictionary:(NSDictionary *)dictionary;

@end
