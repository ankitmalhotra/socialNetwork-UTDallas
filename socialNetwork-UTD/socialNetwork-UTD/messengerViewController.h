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
/*Flag to tell message posts are fetched and ready to be shown in text view*/
static int showPosts=0;
/*Mutable Array object to collate group names inbound from server*/
static NSMutableArray *groups;
/*Mutable Array object to collate friend names inbound from server*/
static NSMutableArray *friends;
/*Stores the userId (NOT user name)*/
static NSString *username;
/*Stores the user's password*/
static NSString *userpwd;
/*Stores the user's emailID*/
static NSString *userMailID=NULL;
/*Stores the selected group name from group table view*/
static NSString *grpname;
/*Stores the selected friend name from friend table view*/
static NSString *friendname;
/*Mutable Array object to collate message post data from server*/
static NSMutableArray *messagePostData;
/*String to show message data in text view*/
static NSMutableArray *messageDataToShow;
/*String to show username data in text view*/
static NSMutableArray *userNameDataToShow;
/*Stores location latitude*/
static double locationLatitude;
/*Stores location latitude*/
static double locationLongitude;

@interface messengerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    /*Core IB-Outlets*/
    IBOutlet UIBarButtonItem *friendsBtn;
    IBOutlet UIBarButtonItem *groupsBtn;
    IBOutlet UIBarButtonItem *postBtn;
    IBOutlet UIBarButtonItem *stopUpdate;
    IBOutlet UITableView *postsViewer;
    
    /*Objects to be used*/
    messengerRESTclient *restObj;
    groupsTableViewViewController *groupViewObj;
    newPostViewController *newPostObj;
    
    /*Stores return status from REST calls to specific endpoints*/
    int retVal;
}


-(void)getUserId :(NSString *)userId :(NSString *)userPassword;
-(void)getUserMailID :(NSString *)mailID;
-(IBAction)showGroups;
-(IBAction)showFriends;
-(NSMutableArray *)getGroupObjects :(NSMutableArray *)inputArray :(int)toReturn;
-(NSMutableArray *)getFriendObjects : (NSMutableArray *)inputArray :(int)toReturn;
-(void)collectedPostData : (NSMutableArray *)inputArray;
-(void)setSelectedIndex:(NSString *)indexVal;
-(void)setSelectedIndexFriends:(NSString *)indexVal;
-(IBAction)createPost;
-(IBAction)stopUpdate;
-(void)clearBufferList;
-(NSString *)signalGroupName;
-(void)showPostData:(NSString *)groupName;
-(void)showNewPosts;


@end
