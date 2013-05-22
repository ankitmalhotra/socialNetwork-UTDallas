//
//  messengerViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 10/10/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "groupsTableViewViewController.h"
#import "friendsViewController.h"
#import "newPostViewController.h"
#import "signupUserViewController.h"
#import "messengerRESTclient.h"
#import "userChatViewController.h"
#import "detailMessageViewController.h"

@class groupsTableViewViewController;
@class messengerRESTclient;
@class newPostViewController;
@class friendsViewController;
@class userChatViewController;
@class detailMessageViewController;


@interface messengerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    /*Core IB-Outlets*/
    IBOutlet UIBarButtonItem *friendsBtn;
    IBOutlet UIBarButtonItem *groupsBtn;
    IBOutlet UIBarButtonItem *postBtn;
    IBOutlet UITableView *postsViewer;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIActivityIndicatorView *connProgress;
    
    UIRefreshControl *refreshControl;
    NSString *cellDetailTextLabel;
    
    /*Objects to be used*/
    messengerRESTclient *restObj;
    groupsTableViewViewController *groupViewObj;
    newPostViewController *newPostObj;
    friendsViewController *friendObj;
    userChatViewController *userChatObj;
    detailMessageViewController *detailMsgViewObj;
    
    /*Stores return status from REST calls to specific endpoints*/
    int retVal;
    
    NSString *selectedPost;
}


/*Method signatures*/
-(void)getUserId :(NSString *)userId :(NSString *)userPassword;
-(void)getUserMailID :(NSString *)mailID;
-(IBAction)showGroups;
-(IBAction)showFriends;
-(NSMutableArray *)getGroupObjects :(NSMutableArray *)inputArray :(int)toReturn;
-(NSMutableArray *)getFriendObjects :(NSMutableArray *)inputArray :(int)toReturn;
-(void)collectedPostData :(NSMutableArray *)inputArray;
-(void)setSelectedIndex:(NSString *)indexVal;
-(void)setSelectedIndexFriends:(NSString *)indexVal;
-(IBAction)createPost;
-(void)stopUpdate;
-(void)refreshTableView;
-(void)clearBufferList;
-(void)clearAllPosts;
-(NSString *)signalGroupName;
-(NSMutableArray *)signalFriends;
-(void)showPostData :(NSString *)groupName;
-(void)storeUserNumber :(NSMutableArray *)userNum;
-(void)initLocUpdate;
-(void)getGeoCoords :(double)latitude :(double)longitude;


@end
