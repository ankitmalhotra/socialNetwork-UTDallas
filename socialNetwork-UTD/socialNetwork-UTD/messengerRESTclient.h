//
//  messengerRESTclient.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRESTparser.h"
#import "messengerAppDelegate.h"
#import "ChallengeHandler.h"

@class BaseRESTparser; /*use this forward declaration to avoid class parse issues*/
@class ChallengeHandler;
@class messengerAppDelegate;

static NSString *serviceEndPoint;
static int valueToReturn=0;

@interface messengerRESTclient : NSObject<NSURLConnectionDelegate,ChallengeHandlerDelegate>
{
    BaseRESTparser *accessPtr;
    NSMutableData *wipData;
    ChallengeHandler *currentChallenge;
    NSURLConnection *connection;
    NSTimer *earlyTimeoutTimer;
}

-(void)receiveMessage:(NSString *)endPoint;
-(int)sendMessage :(NSString *)userID :(NSString *)userName :(NSString *)password :(NSString *)emailID :(NSString *)endPointURL;
-(int)createGroup:(NSString *)userID :(NSString *)groupName :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;
-(int)createNewPost:(NSString *)userID :(NSString *)groupName :(NSString *) postData : (double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;

-(void)valueToReturn:(int)value;
-(int)returnValue;
-(void)_startReceive;


@end
