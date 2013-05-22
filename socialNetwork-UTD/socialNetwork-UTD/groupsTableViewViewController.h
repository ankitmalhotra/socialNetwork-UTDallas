//
//  groupsTableViewViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"
#import "newPostViewController.h"
#import "messengerRESTclient.h"

@class messengerViewController;
@class messengerRESTclient;
@class newPostViewController;

@interface groupsTableViewViewController : UIViewController
         <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView *tabVw;
    IBOutlet UIBarButtonItem *addGrp;
    IBOutlet UIBarButtonItem *showAll;
    IBOutlet UIBarButtonItem *backToMain;
    IBOutlet UIActivityIndicatorView *connProgress;
    
    //dispatch_queue_t fetchMyGroupsQueue;
    //dispatch_queue_t fetchOtherGroupsQueue;

    NSString *newGroupName;
    UITextField *groupNameField;
    UIRefreshControl *refreshCntl;
    int retval;
    
    messengerViewController *mainViewObj;
    messengerRESTclient *restObj;
    newPostViewController *newPostObj;
}

-(IBAction)backToMain;
-(IBAction)createGroup;
-(IBAction)showAllGroups;
-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude;
-(void)getUserData: (NSString *)userId :(NSString *)userPwd :(NSString *)userEmailID;
-(void)getUserNumber: (NSString *)userNum;

@end
