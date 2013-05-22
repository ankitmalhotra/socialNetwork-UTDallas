//
//  signupUserViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/30/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "signupUserViewController.h"

@interface signupUserViewController ()

@end

@implementation signupUserViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    mainViewObj=[[messengerViewController alloc]init];
    restObj=[[messengerRESTclient alloc]init];
    appDelegateObj=[[messengerAppDelegate alloc]init];
}

-(IBAction)switchBackLogin
{
    /*Push back to login view*/
    [self dismissViewControllerAnimated:YES completion:nil];
    
    /*Release allocated objects*/
    [mainViewObj release];
    [restObj release];
    [appDelegateObj release];
}

/*Resign the keyboard on pressing return*/
-(IBAction)returnKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)sendNewUserData
{
    userID=dispNameField.text;
    userName=realNameField.text;
    password=newPasswordField.text;
    retypePwd=retypePasswordField.text;
    emailID=emailField.text;
    NSLog(@"password: %@",password);
    NSLog(@"retypePwd: %@",retypePwd);
    if([password isEqualToString:retypePwd] && userName!=NULL && userID!=NULL)
    {
        /*Retreive the device token ID*/
        deviceToken=[appDelegateObj getDeviceToken];
        NSString *tokenstr=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        tokenstr=[tokenstr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"My local token is: %@", tokenstr);
        
        /*Call to add-new-user endpoint*/
        [restObj sendMessage:userID :userName :password :emailID :tokenstr :@"add"];
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"calling for status !");
            retVal=[restObj returnValue];
            if(retVal==1)
            {
                [mainViewObj getUserMailID:emailID];
                [self dismissViewControllerAnimated:YES completion:nil];
                UIAlertView *signUpSuccessAlert=[[UIAlertView alloc]initWithTitle:@"SignUp successful" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [signUpSuccessAlert show];
                [signUpSuccessAlert release];
                
                /*Release allocated objects*/
                [mainViewObj release];
                [restObj release];
                [appDelegateObj release];
            }
            else
            {
                UIAlertView *signUpFailAlert=[[UIAlertView alloc]initWithTitle:@"SignUp Failed" message:@"Connection failiure" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [signUpFailAlert show];
                [signUpFailAlert release];
            }

        });
    }
    else if(![password isEqualToString:retypePwd])
    {
        UIAlertView *wrongPwd=[[UIAlertView alloc]initWithTitle:@"Password mismatch !" message:@"Please retype the password correctly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [wrongPwd show];
        [wrongPwd release];
        retypePwd=NULL;
        password=NULL;
        newPasswordField.text=NULL;
        retypePasswordField.text=NULL;
    }
    else if (userName==NULL)
    {
        UIAlertView *wrongUserName=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must provide a real name to begin" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [wrongUserName show];
        [wrongUserName release];
        retypePwd=NULL;
        password=NULL;
        newPasswordField.text=NULL;
        retypePasswordField.text=NULL;
    }
    else if (userID==NULL)
    {
        UIAlertView *wrongUserID=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You must provide a user name to begin" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [wrongUserID show];
        [wrongUserID release];
        retypePwd=NULL;
        password=NULL;
        newPasswordField.text=NULL;
        retypePasswordField.text=NULL;
    }

}


-(IBAction)backgroundTouched:(id)sender
{
    [dispNameField resignFirstResponder];
    [retypePasswordField resignFirstResponder];
    [emailField resignFirstResponder];
    [newPasswordField resignFirstResponder];
    [realNameField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
