//
//  friendsViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 17/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"

@class messengerViewController;

@interface friendsViewController : UIViewController
        <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tabVw;
    NSArray *friendList;
    NSString *selectedIndex;
    
    messengerViewController *setIndexObj;
    messengerViewController *grabFriendObj;
}

-(IBAction)backToMain;

@end
