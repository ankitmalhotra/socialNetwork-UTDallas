//
//  groupsTableViewViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"
#import "messengerRESTclient.h"

@class messengerViewController;
@class messengerRESTclient;

static double locationLat,locationLong;
static NSString *localUserId;

@interface groupsTableViewViewController : UIViewController
         <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView *tabVw;
    NSArray *groupList;
    NSString *selectedIndex;
    NSString *grpName;
    UITextField *groupNameField;
    int retval;
    
    messengerViewController *grabGroupsObj;
    messengerViewController *grabLocationCoordsObj;
    messengerRESTclient *restObj;
}

-(IBAction)backToMain;
-(IBAction)createGroup;
-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude;
-(void)getUserId:(NSString *)userId;

@end
