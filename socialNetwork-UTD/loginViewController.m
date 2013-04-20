//
//  loginViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 13/11/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "loginViewController.h"
#import "messengerViewController.h"

@interface loginViewController ()
{
    /*User credentials*/
    NSString *userId;
    NSString *userPwd;
}
@end
    
@implementation loginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    spinningView.hidden=TRUE;
    appearFlagCheck=1;
    receivedStatus=0;
    NSLog(@"loaded");
    NSLog(@"flagval: %d",appearFlagCheck);
    
    obj=[[messengerViewController alloc]init];
    restObj=[[messengerRESTclient alloc]init];
}

-(IBAction)swichBackMain
{
    /*Accept username and password entered by user*/
    userId = nameField.text;
    userPwd = passwordField.text;
    
    /*Start REST request*/
    spinningView.hidden=FALSE;
    [spinningView startAnimating];
    
    /*Pass this username to server*/
    [restObj sendMessage:userId :nil :userPwd :nil :nil :@"login"];
    double delayInSeconds = 2.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"calling for status !");
    receivedStatus=[restObj returnValue];
    NSLog(@"status received:%d",receivedStatus);
    if(receivedStatus==1)
    {
        /*Signal username to main view*/
        obj=[[messengerViewController alloc]init];
        [obj getUserId:userId:@"test"];
        [obj release];
        
        /*Generate Key Pairs routine*/
        [secureMessageRSA generateKeyPairs];
            
        /*Push back main view*/
        messengerViewController *mainVw=[[messengerViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:mainVw animated:YES completion:NULL];
        [spinningView stopAnimating];
        [mainVw release];
    }
    else if(receivedStatus==-1)
    {
        UIAlertView *loginFail=[[UIAlertView alloc]initWithTitle:@"Login Failed" message:@"Please check the login credentials" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [loginFail show];
        [loginFail release];
        [spinningView stopAnimating];
        spinningView.hidden=TRUE;
    }
    else if(receivedStatus==0)
    {
        UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connNullAlert show];
        [connNullAlert release];
        [spinningView stopAnimating];
        spinningView.hidden=TRUE;
        switchBackBtn.enabled=TRUE;
    }

    });
}

/*Load new user signup view*/
-(IBAction)signupUser
{
    signupUserViewController *signupObj=[[signupUserViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:signupObj animated:YES completion:nil];
    [signupObj release];
}

/*Resign the keyboard on pressing return*/
-(IBAction)returnKeyBoard:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)backgroundTouched:(id)sender
{
    [nameField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end
