//
//  AESHelper.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#import <Foundation/Foundation.h>

//二次封装加解密，用下面这俩
NSString * aesEncrypt(NSString *content);
NSDictionary * aesDecryptWithData(NSData *content);

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);
