//
//  newPostViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 01/01/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerRESTclient.h"
#import "messengerViewController.h"

@class messengerRESTclient;
@class messengerViewController;

@interface newPostViewController : UIViewController
{    
    IBOutlet UIBarButtonItem *cancelButton;
    IBOutlet UITextView *messageVw;
    IBOutlet UIBarButtonItem *postButton;
    int retVal;
    
    messengerRESTclient *restObj;
    messengerViewController *mainViewObj;
}

-(IBAction)createNewPost;
-(IBAction)backToMain;
-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude;
-(void)getUserId:(NSString *)userId;
-(void)setUserGroup;

@end
