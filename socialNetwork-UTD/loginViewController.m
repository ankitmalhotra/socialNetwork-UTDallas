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
    NSLog(@"loaded");
    NSLog(@"flagval: %d",appearFlagCheck);    
}

-(IBAction)swichBackMain
{
    /*Accept username and password entered by user*/
    userId = nameField.text;
    userPwd = passwordField.text;
    /*Signal username to main view*/
    messengerViewController *obj=[[messengerViewController alloc]init];
    [obj getUserId:userId];
    
    /*Start REST request*/
    spinningView.hidden=FALSE;
    [spinningView startAnimating];
    //[obj processRequest];
    restObj=[[messengerRESTclient alloc]init];
    /*Pass this username to server*/
    retVal=[restObj sendMessage:userId :nil :userPwd :nil :@"login"];
    if (retVal==1)
    {
        /*Generate Key Pairs routine*/
        [secureMessageRSA generateKeyPairs];
        
        /*Push back main view*/
        messengerViewController *mainVw=[[messengerViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:mainVw animated:YES completion:NULL];
        [restObj receiveMessage:@"list"];
        [spinningView stopAnimating];
    }
    else
    {
        UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connNullAlert show];
        [connNullAlert release];
        [spinningView stopAnimating];
        spinningView.hidden=TRUE;
        switchBackBtn.enabled=TRUE;
    }
}

/*Load new user signup view*/
-(IBAction)signupUser
{
    signupUserViewController *signupObj=[[signupUserViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:signupObj animated:YES completion:nil];
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
