//
//  AddressBookModel.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookModel.h"

@implementation AddressBookModel

- (instancetype)initAddressBookWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

+ (instancetype)addressBookWithDictionary:(NSDictionary *)dictionary {
    return [[AddressBookModel alloc] initAddressBookWithDictionary:dictionary];
}

/**
 *  复写description方法
 */
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p>{userName:%@, phoneNum:%@}", self.class, self, self.userName, self.phoneNum];
}

@end
