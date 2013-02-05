//
//  secureMessageRSA.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/11/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface secureMessageRSA : NSObject


+(void)generateKeyPairs;
+(void)encryptMessage:(NSString *)message;
+(void)decryptMessage;

@end
