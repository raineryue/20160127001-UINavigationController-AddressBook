//
//  AddressBookModel.m
//  20160127001-UINavigationController-AddressBook
//
//  Created by Rainer on 16/1/28.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "AddressBookModel.h"

@implementation AddressBookModel

/**
 *  根据字典创建一个联系人模型（对象方法）
 */
- (instancetype)initAddressBookWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

/**
 *  根据字典创建一个联系人模型（类方法）
 */
+ (instancetype)addressBookWithDictionary:(NSDictionary *)dictionary {
    return [[AddressBookModel alloc] initAddressBookWithDictionary:dictionary];
}

/**
 *  属性编码
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_phoneNum forKey:@"phoneNum"];
}

/**
 *  初始化属性
 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _userName = [aDecoder decodeObjectForKey:@"userName"];
        _phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
    }
    
    return self;
}

/**
 *  复写description方法
 */
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@:%p>{userName:%@, phoneNum:%@}", self.class, self, self.userName, self.phoneNum];
}

@end
