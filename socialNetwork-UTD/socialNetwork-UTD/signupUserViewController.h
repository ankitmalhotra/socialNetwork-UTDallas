//
//  signupUserViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/30/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"
#import "messengerRESTclient.h"
#import "messengerAppDelegate.h"

/*use this forward declaration to avoid class parse issues*/
@class messengerRESTclient;
@class messengerAppDelegate;
@class messengerViewController;

@interface signupUserViewController : UIViewController
{
    IBOutlet UIButton *goBtn;
    IBOutlet UIBarButtonItem *backToLoginBtn;
    IBOutlet UITextField *dispNameField;
    IBOutlet UITextField *realNameField;
    IBOutlet UITextField *newPasswordField;
    IBOutlet UITextField *retypePasswordField;
    IBOutlet UITextField *emailField;
    
    NSString *userID;
    NSString *userName;
    NSString *password;
    NSString *retypePwd;
    NSString *emailID;
    
    NSData *deviceToken;
    
    int retVal;
    
    messengerRESTclient *restObj;
    messengerAppDelegate *appDelegateObj;
    messengerViewController *mainViewCntrlObj;
    
}

-(IBAction)returnKeyboard:(id)sender;
-(IBAction)switchBackLogin;
-(IBAction)sendNewUserData;
-(IBAction)backgroundTouched:(id)sender;


@end
