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
    
    /*Retrive the group name selected from main view*/
    [self getUserGroup];
    
    /*Place call to server with new post data & user,group,coord details*/
    retVal=[restObj createNewPost:localUserId :localGroupName :messageData :locationLat :locationLong :@"postMessage"];
    if(retVal==1)
    {
        NSLog(@"calling for status from server..");
        receivedStatus=[restObj returnValue];
        NSLog(@"status received:%d",receivedStatus);
        if(receivedStatus==1)
        {
            /*Call encryption routine to encrypt the message*/
            [secureMessageRSA encryptMessage:messageData];
            [secureMessageRSA decryptMessage];
            
            UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"Message Successfully posted to group: %@",localGroupName] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [createdAlert show];
            [createdAlert release];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"New Message could not be posted"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [createdAlert show];
            [createdAlert release];
        }
    }
    else
    {
        UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connNullAlert show];
        [connNullAlert release];
    }

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
-(void)getUserGroup
{
    localGroupName=[mainViewController signalGroupName];
    NSLog(@"received userGroup: %@",localGroupName);
}


@end
