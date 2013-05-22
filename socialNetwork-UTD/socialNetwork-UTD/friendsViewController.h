//
//  friendsViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 17/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"
#import "userChatViewController.h"

@class messengerViewController;
@class userChatViewController;


@interface friendsViewController : UIViewController
        <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tabVw;
    UIRefreshControl *refreshControl;
    
    NSArray *friendList;
    NSString *selectedIndex;
    NSDictionary *friendDictionary;
    
    messengerViewController *mainViewObj;
    userChatViewController *userChatObj;
}

-(IBAction)backToMain;
-(void)refreshUI;
-(void)getFriendNumbers: (NSArray *)friendNum;


@end
