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

static double locationLat,locationLong;
static NSString *localUserId;
static NSString *selectedIndex;
static NSArray *groupList;

@interface groupsTableViewViewController : UIViewController
         <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView *tabVw;
    NSString *grpName;
    UITextField *groupNameField;
    int retval;
    
    messengerViewController *setIndexObj;
    messengerViewController *grabGroupsObj;
    messengerRESTclient *restObj;
    newPostViewController *newPostObj;
}

-(IBAction)backToMain;
-(IBAction)createGroup;
-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude;
-(void)getUserId:(NSString *)userId;

@end
