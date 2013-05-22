//
//  messengerAppDelegate.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 10/10/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "messengerViewController.h"
#import "userChatViewController.h"

@class messengerViewController,loginViewController,userChatViewController;


@interface messengerAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger *networkingCount;
    NSData *devToken;
    
    userChatViewController *chatViweObj;
    NSString *_senderName;
    NSString *_chatMessage;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) messengerViewController *viewController;

@property (strong, nonatomic) CLLocationManager *locationManager;

//-(void)didStartNetworking;
+ (messengerAppDelegate *)sharedAppDelegate;
- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI;
- (NSURL *)smartURLForString:(NSString *)str;
- (NSData *)getDeviceToken;

@end
