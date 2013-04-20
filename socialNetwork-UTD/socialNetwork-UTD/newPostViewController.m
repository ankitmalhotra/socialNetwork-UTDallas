//
//  newPostViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 01/01/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "newPostViewController.h"
#import "secureMessageRSA.h"


@implementation newPostViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    restObj=[[messengerRESTclient alloc]init];
    mainViewController=[[messengerViewController alloc]init];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)backToMain
{
    /*Call clear buffer in main view*/
    [mainViewController clearBufferList];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)createNewPost
{
    NSString *messageData;
    messageData=messageVw.text;
    
    [self setUserGroup];
    NSLog(@"received: %@",localGrpName);
    /*Place call to server with new post data & user,group,coord details*/
    [restObj createNewPost:localUserId :localGrpName :messageData :locationLat :locationLong :@"postMessage"];
    double delayInSeconds = 2.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    NSLog(@"calling for status from server..");
    receivedStatus=[restObj returnValue];
    NSLog(@"status received:%d",receivedStatus);
    if(receivedStatus==1)
    {
        /*Call to main to update table view for new post*/
        [mainViewController showNewPosts];
        /*Call encryption routine to encrypt the message*/
        [secureMessageRSA encryptMessage:messageData];
        [secureMessageRSA decryptMessage];
                
        UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"Message Successfully posted"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [createdAlert show];
        [createdAlert release];
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    else if (receivedStatus==0)
    {
        UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connNullAlert show];
        [connNullAlert release];
    }
    else if(receivedStatus==-1)
    {
        UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"New Message could not be posted"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [createdAlert show];
        [createdAlert release];
    }
    });
}

/*This method will be invoked by main view which will pass location coordinates*/
-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude
{
    locationLat=locationLatitude;
    locationLong=locationLongitude;
    NSLog(@"received coords: lat: %f ,long: %f",locationLat,locationLong);
}

/*This method will be invoked by main view which will pass currently signed userId*/
-(void)getUserId:(NSString *)userId
{
    localUserId=userId;
    NSLog(@"received userId: %@",localUserId);
}

/*This method invoked locally will call main view to retrieve the group name selected*/
-(void)setUserGroup
{
    localGrpName=[mainViewController signalGroupName];
}


@end
