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

@class messengerRESTclient;  /*use this forward declaration to avoid class parse issues*/

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
    int retVal;
    
    messengerRESTclient *restObj;
    
}

-(IBAction)returnKeyboard:(id)sender;
-(IBAction)switchBackLogin;
-(IBAction)sendNewUserData;
-(IBAction)backgroundTouched:(id)sender;


@end
