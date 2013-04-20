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

/*endpoint URL received*/
static NSString *serviceEndPoint;
static int valueToReturn=0;
static int statusSignal=0;



@interface messengerRESTclient : NSObject<NSURLConnectionDelegate,ChallengeHandlerDelegate>
{
    BaseRESTparser *accessPtr;
    NSMutableData *wipData;
    ChallengeHandler *currentChallenge;
    NSURLConnection *connection;
    NSTimer *earlyTimeoutTimer;
}

-(void)receiveMessage:(NSString *)endPoint;
-(void)sendMessage :(NSString *)userID :(NSString *)userName :(NSString *)password :(NSString *)emailID :(NSString *)devToken :(NSString *)endPointURL;
-(void)createGroup:(NSString *)userID :(NSString *)groupName :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;
-(void)createNewPost:(NSString *)userID :(NSString *)groupName :(NSString *) postMessage : (double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;
-(void)showPostData:(NSString *)groupName :(NSString *)endPointURL;
-(void)showAllGroups:(NSString *)userID :(NSString *)password :(NSString *)emailID :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;
-(void)getFriendList: (NSString *)userID :(NSString *)groupName :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL;
-(void)valueToReturn:(int)value;
-(int)returnValue;
-(int)returnStatusSignal;


@end
