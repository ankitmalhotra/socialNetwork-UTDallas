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

@class messengerViewController,loginViewController;

@interface messengerAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger *networkingCount;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) messengerViewController *viewController;

@property (strong, nonatomic) CLLocationManager *locationManager;

-(void)didStartNetworking;
+ (messengerAppDelegate *)sharedAppDelegate;
- (NSURL *)smartURLForString:(NSString *)str;

@end
