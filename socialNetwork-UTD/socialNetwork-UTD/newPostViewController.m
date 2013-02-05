//
//  newPostViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 01/01/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "newPostViewController.h"
#import "secureMessageRSA.h"

@interface newPostViewController ()

@end

@implementation newPostViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)backToMain
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)createNewPost
{
    NSString *messageData;
    messageData=messageVw.text;
    
    /*Call encryption routine to encrypt the message*/
    [secureMessageRSA encryptMessage:messageData];
    [secureMessageRSA decryptMessage];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

@end
