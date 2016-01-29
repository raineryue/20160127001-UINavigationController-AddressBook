//
//  AddressBookModel.h
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *userName;
/** 电话 */
@property (nonatomic, copy) NSString *phoneNum;

/**
 *  根据字典创建一个联系人模型（对象方法）
 */
- (instancetype)initAddressBookWithDictionary:(NSDictionary *)dictionary;

/**
 *  根据字典创建一个联系人模型（类方法）
 */
+ (instancetype)addressBookWithDictionary:(NSDictionary *)dictionary;

@end
