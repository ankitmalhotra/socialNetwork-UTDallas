//
//  messengerViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 10/10/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupsTableViewViewController.h"
#import "friendsViewController.h"
#import "newPostViewController.h"
#import "signupUserViewController.h"
#import "messengerRESTclient.h"

@class messengerRESTclient;

/*static variable declaration*/

/*Flag to ensure initial login view is displayed only once*/
static int appearCheck=0;
/*Mutable Array object to collate group names inbound from server*/
static NSMutableArray *groups;
/*Mutable Array object to collate friend names inbound from server*/
static NSMutableArray *friends;

@interface messengerViewController : UIViewController
{
    IBOutlet UIBarButtonItem *friendsBtn;
    IBOutlet UIBarButtonItem *groupsBtn;
    IBOutlet UIBarButtonItem *postBtn;
    IBOutlet UIBarButtonItem *stopUpdate;
    
    messengerRESTclient *restObj;
}

@property (readwrite,assign) NSString *gpNames;

-(IBAction)backgroundTouched:(id)sender;
-(void)getUserId:(NSString *)userId;
-(IBAction)showGroups;
-(IBAction)showFriends;
-(NSMutableArray *)setGroupObjects:(NSMutableArray *)inputArray:(int)toReturn;
-(NSMutableArray *)getFriendObjects: (NSMutableArray *)inputArray:(int)toReturn;
-(void)setSelectedIndex:(NSString *)indexVal;
-(IBAction)createPost;
-(IBAction)stopUpdate;


@end
