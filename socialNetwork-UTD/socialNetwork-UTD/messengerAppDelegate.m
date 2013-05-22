//
//  messengerAppDelegate.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 10/10/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "messengerAppDelegate.h"

#import "messengerViewController.h"
#import "loginViewController.h"


@implementation messengerAppDelegate

@synthesize locationManager=_locationManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    chatViweObj = [[userChatViewController alloc]init];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[messengerViewController alloc] initWithNibName:@"messengerViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    /*Informing device about Push notification enablement*/
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge];
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound];
    
    if (launchOptions != nil)
	{
		NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
			[self addMessageFromRemoteNotification:dictionary updateUI:NO];
		}
	}
    
    return YES;
}

/*Device token to be used by the server. This token serves as an address of device for the server to begin pushing messages*/
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    devToken=deviceToken;
    [devToken retain];
}

-(NSData *)getDeviceToken
{
    return devToken;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
	[self addMessageFromRemoteNotification:userInfo updateUI:YES];
}



- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
{    
	NSString* alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    NSString* senderValue = [userInfo valueForKey:@"sender"];
    
    if(alertValue!=NULL)
    {
        NSMutableArray* alertParts = [NSMutableArray arrayWithArray:[alertValue componentsSeparatedByString:@": "]];
        _chatMessage = [alertParts objectAtIndex:0];
        [alertParts removeObjectAtIndex:0];
    }
    if(senderValue!=NULL)
    {
        NSMutableArray* senderParts = [NSMutableArray arrayWithArray:[senderValue componentsSeparatedByString:@": "]];
        _senderName = [senderParts objectAtIndex:0];
    }
    
	if (updateUI)
    {
		[chatViweObj showNewMessage:_chatMessage :_senderName];
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //[self release];
    //[super dealloc];
    //NSLog(@"release called");

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //[self init];
    //NSLog(@"awake called");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskAll;
}


- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}

/*
- (void)didStartNetworking
{
    networkingCount += 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didStopNetworking
{
    assert(networkingCount > 0);
    networkingCount -= 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = (networkingCount != 0);
}
*/

+ (messengerAppDelegate *)sharedAppDelegate
{
    return (messengerAppDelegate *) [UIApplication sharedApplication].delegate;
}

@end
