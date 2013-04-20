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
}

-(IBAction)switchBackLogin
{
    /*Push back to login view*/
   // loginViewController *loginPtr=[[loginViewController alloc]initWithNibName:nil bundle:nil];
    //[self presentViewController:loginPtr animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if([password isEqualToString:retypePwd])
    {
        /*Request to "add" endpoint for new user registration*/
        restObj=[[messengerRESTclient alloc]init];
        /*Retreive the device token ID*/
        appDelegateObj=[[messengerAppDelegate alloc]init];
        deviceToken=[appDelegateObj getDeviceToken];
        NSString *tokenstr=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
        tokenstr=[tokenstr stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"My local token is: %@", tokenstr);
        
        [restObj sendMessage:userID :userName :password :emailID :tokenstr :@"add"];
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"calling for status !");
            retVal=[restObj returnValue];
            if(retVal==1)
            {
                [mainViewCntrlObj getUserMailID:emailID];
                [self dismissViewControllerAnimated:YES completion:nil];
                UIAlertView *signUpSuccessAlert=[[UIAlertView alloc]initWithTitle:@"SignUp successful" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [signUpSuccessAlert show];
                [signUpSuccessAlert release];
            }
            else
            {
                UIAlertView *signUpFailAlert=[[UIAlertView alloc]initWithTitle:@"SignUp Failed" message:@"Connection failiure" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [signUpFailAlert show];
                [signUpFailAlert release];
            }

        });
    }
    else
    {
        UIAlertView *wrongPwd=[[UIAlertView alloc]initWithTitle:@"Password mismatch !" message:@"Please retype the password correctly" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [wrongPwd show];
        [wrongPwd release];
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
