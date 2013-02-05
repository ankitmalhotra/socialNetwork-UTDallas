//
//  messengerRESTclient.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRESTparser.h"

@class BaseRESTparser; /*use this forward declaration to avoid class parse issues*/

static NSString *serviceEndPoint;

@interface messengerRESTclient : NSObject<NSURLConnectionDelegate>
{
    BaseRESTparser *accessPtr;
    NSMutableData *wipData;
}

-(void)receiveMessage:(NSString *)endPoint;
-(int)sendMessage:(NSString *)userID:(NSString *)userName:(NSString *)password:(NSString *)emailID:(NSString *)endPointURL;

@end
