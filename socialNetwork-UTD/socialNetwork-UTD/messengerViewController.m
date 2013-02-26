//
//  messengerViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 10/10/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "messengerViewController.h"
#import "messengerAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "secureMessageRSA.h"
//#import <Security/Security.h>
//#import <CommonCrypto/CommonCrypto.h>
//#import <CommonCrypto/CommonDigest.h>
#define kGeoCodingString @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"

@interface messengerViewController ()
{
    /*Location constants*/
    CLLocationManager *locManager;
    
    /*User credentials*/
    NSString *userPwd;    
}

@end


@implementation messengerViewController


- (void)viewDidLoad
{
    NSLog(@"val is: %d",appearCheck);
    
    /*Object instantiations*/
    groups=[[NSMutableArray alloc]init];
    friends=[[NSMutableArray alloc]init];
    restObj=[[messengerRESTclient alloc]init];
    groupViewObj=[[groupsTableViewViewController alloc]init];
    newPostObj=[[newPostViewController alloc]init];
    
    [super viewDidLoad];

    /*Get Location*/
    locManager=[[CLLocationManager alloc] init];
    locManager.delegate=self;
    locManager.desiredAccuracy=kCLLocationAccuracyBest;
    locManager.distanceFilter=0.0f;
    if([CLLocationManager locationServicesEnabled])
    {
        [locManager startUpdatingLocation];
    }
    
    /*Set the label to display the logged-in user's ID*/
    UILabel *userIdLabel=[[UILabel alloc]initWithFrame:CGRectMake(135, 42, 91, 21)];
    userIdLabel.text=username;
    userIdLabel.numberOfLines=3;
    userIdLabel.backgroundColor=[UIColor clearColor];
    userIdLabel.textColor=[UIColor blackColor];
    userIdLabel.font=[UIFont systemFontOfSize:14.0];
    [self.view addSubview: userIdLabel];
            
}

-(void)viewDidAppear:(BOOL)animated
{
    /*load up login view*/
    NSLog(@"check_flag: %d",appearCheck);
    if(appearCheck==0)
    {
        appearCheck=1;
        loginViewController *loginVw=[[loginViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:loginVw animated:YES completion:NULL];
    }
}


/*Define group values to be shown in group tableview*/
-(NSMutableArray *)getGroupObjects :(NSMutableArray *)arrayInput :(int)toReturn
{
    /*If toReturn is 1: collate the data inbound into "groups object*/
    if(toReturn==1)
    {
        [groups addObjectsFromArray:arrayInput];
        NSLog(@"group data received: %@",groups);
        return NULL;
    }
    /*If toReturn is 0: return the collated data to show in table*/
    else
    {
        NSLog(@"showing group data: %@",groups);
        return groups;
    }
}

/*Define friend values to be shown in friend tableview*/
-(NSArray *)getFriendObjects :(NSMutableArray *)arrayInput :(int)toReturn
{
    /*If toReturn is 1: collate the data inbound into "friends object*/
    if(toReturn==1)
    {
        [friends addObjectsFromArray:arrayInput];
        NSLog(@"friend data received: %@",friends);
        return NULL;
    }
    /*If toReturn is 0: return the collated data to show in table*/
    else
    {
        NSLog(@"showing friend data: %@",friends);
        return friends;
    }
}


/*Receive the index selected in group tableview*/
-(void)setSelectedIndex:(NSString *)indexVal
{
    selectedGroupNameIndex=indexVal;
    NSLog(@"index selected: %@",selectedGroupNameIndex);
}

-(NSString *)signalGroupName
{
    return selectedGroupNameIndex;
}

/*Setting the username received from loginView*/
-(void)getUserId:(NSString *)userId
{
    username=userId;
    NSLog(@"name is: %@",username);
}



/*Location update function calls*/

-(void) locationManager:(CLLocationManager*)locManager
    didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*)oldLocation
{
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 100000.0)
    {
        NSString *showPos=[NSString stringWithFormat:@"lat: %f,long: %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude ];
        double latPos=newLocation.coordinate.latitude;
        double longPos=newLocation.coordinate.longitude;
        NSLog(@"Current user position: %@",showPos);
        
        /*Signal location co-ords to groupsTableView(to be used for new group creation)*/
        [groupViewObj getLocationCoords:latPos :longPos];
        
        /*Signal location co-ords to groupsTableView(to be used for new group creation)*/
        [newPostObj getLocationCoords:latPos :longPos];
        
        /*Signal userId to groupsTableView(to be used for new group creation*/
        [groupViewObj getUserId:username];
        
        /*Signal userId to groupsTableView(to be used for new group creation*/
        [newPostObj getUserId:username];
        
        /*
        typedef double CLLocationDistance;
        CLLocationDistance dist = [oldLocation distanceFromLocation:newLocation];
        NSLog(@"distance moved: %f meters",(dist));
        NSString *distmoved=[NSString stringWithFormat:@"You just moved: %f meters",(dist)];
        */
        
        /*Reverse Geo-coding*/
        NSString *urlLoc=[NSString stringWithFormat:kGeoCodingString,latPos,longPos];
        NSError *errMsg;
        NSString *locString=[NSString stringWithContentsOfURL:[NSURL URLWithString:urlLoc] encoding:NSASCIIStringEncoding error:&errMsg];
        locString = [locString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"You're at: %@",[locString substringFromIndex:6]);
    }
}

-(BOOL)shouldAutorotate
{
    return NO;
}

/*Clear the group list mutable array object(groups) when group tableview is dismissed*/
-(void)clearBufferList
{
    [groups removeAllObjects];
}

/*Show groups listing*/
-(IBAction)showGroups
{
    int retVal=[restObj sendMessage:username :nil :nil :nil :@"listMemberGroups"];
    if(retVal==1)
    {
      groupsTableViewViewController *gTblView=[[groupsTableViewViewController alloc]initWithNibName:nil bundle:nil];
      [self presentViewController:gTblView animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *connErr=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connErr show];
        [connErr release];
    }
}

/*show friends listing */
-(IBAction)showFriends
{
    friendsViewController *fTblView=[[friendsViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:fTblView animated:YES completion:NULL];
}

/*load view for new post*/
-(IBAction)createPost
{
    newPostViewController *newPostView=[[newPostViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:newPostView animated:YES completion:NULL];
}

-(IBAction)stopUpdate
{
    [locManager stopUpdatingLocation];
    NSLog(@"Location updater stoppped.");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end