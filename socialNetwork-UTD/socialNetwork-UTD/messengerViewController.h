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

@class groupsTableViewViewController;
@class messengerRESTclient;
@class newPostViewController;

/*static variable declaration*/

/*Flag to ensure initial login view is displayed only once*/
static int appearCheck=0;
/*Mutable Array object to collate group names inbound from server*/
static NSMutableArray *groups;
/*Mutable Array object to collate friend names inbound from server*/
static NSMutableArray *friends;
/*Stores the userId (NOT user name)*/
static NSString *username;
/*Stores the selected group name from group table view*/
static NSString *selectedGroupNameIndex;

@interface messengerViewController : UIViewController
{
    IBOutlet UIBarButtonItem *friendsBtn;
    IBOutlet UIBarButtonItem *groupsBtn;
    IBOutlet UIBarButtonItem *postBtn;
    IBOutlet UIBarButtonItem *stopUpdate;
    IBOutlet UIScrollView *scrollView;
    
    messengerRESTclient *restObj;
    groupsTableViewViewController *groupViewObj;
    newPostViewController *newPostObj;
}

@property (readwrite,assign) NSString *groups;

-(IBAction)backgroundTouched :(id)sender;
-(void)getUserId :(NSString *)userId;
-(IBAction)showGroups;
-(IBAction)showFriends;
-(NSMutableArray *)getGroupObjects :(NSMutableArray *)inputArray :(int)toReturn;
-(NSMutableArray *)getFriendObjects : (NSMutableArray *)inputArray :(int)toReturn;
-(void)setSelectedIndex:(NSString *)indexVal;
-(IBAction)createPost;
-(IBAction)stopUpdate;
-(void)clearBufferList;
-(NSString *)signalGroupName;


@end
