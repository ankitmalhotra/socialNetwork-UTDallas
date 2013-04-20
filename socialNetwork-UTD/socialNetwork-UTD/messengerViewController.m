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
}

@end


@implementation messengerViewController


- (void)viewDidLoad
{
    NSLog(@"val is: %d",appearCheck);
    
    /*Object instantiations*/
    groups=[[NSMutableArray alloc]init];
    friends=[[NSMutableArray alloc]init];
    messagePostData=[[NSMutableArray alloc]init];
    restObj=[[messengerRESTclient alloc]init];
    groupViewObj=[[groupsTableViewViewController alloc]init];
    newPostObj=[[newPostViewController alloc]init];
    
    [super viewDidLoad];

    /*Setup Location Manager & start updating location*/
    locManager=[[CLLocationManager alloc] init];
    locManager.delegate=self;
    locManager.desiredAccuracy=kCLLocationAccuracyBest;
    locManager.distanceFilter=0.0f;
    if([CLLocationManager locationServicesEnabled])
    {
        [locManager startUpdatingLocation];
    }
    
    /*Set the label to display the logged-in user's ID*/
    UILabel *userIdLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 42, 120, 30)];
    NSString *welcomeMsg=username;
    welcomeMsg=[welcomeMsg stringByAppendingString:@", Hello !"];
    userIdLabel.text=welcomeMsg;
    userIdLabel.numberOfLines=3;
    userIdLabel.backgroundColor=[UIColor clearColor];
    userIdLabel.textColor=[UIColor whiteColor];
    userIdLabel.font=[UIFont systemFontOfSize:18.0];
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
        [loginVw release];
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
    /*If toReturn is 1: collate the data inbound into friends object*/
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
    grpname=[indexVal retain];
    NSLog(@"index selected: %@",grpname);
    [self showPostData:grpname];
}

-(void)setSelectedIndexFriends: (NSString *)indexVal
{
    friendname=[indexVal retain];
    NSLog(@"friend index selected: %@",friendname);
}

-(NSString *)signalGroupName
{
    NSLog(@"group sending: %@",grpname);
    return grpname;
}


-(void)showPostData:(NSString *)groupName
{
    restObj=[[messengerRESTclient alloc]init];
    [restObj showPostData:groupName :@"getGroupMessages"];
    double delayInSeconds = 2.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"calling for status from server..");
        retVal=[restObj returnValue];
        if(retVal==1)
        {
            int k=0;
            messageDataToShow=NULL;
            userNameDataToShow=NULL;
            NSLog(@"messages data count: %d",[messagePostData count]);
            while(k<[messagePostData count] && [messagePostData count]!=1)
            {
                k++;
                messageDataToShow=[messagePostData objectAtIndex:k];
                userNameDataToShow=[messagePostData objectAtIndex:k-1];
                k++;
                showPosts=1;
            }
            
            NSLog(@"about to show");
            double delayInSeconds = 3.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self showNewPosts];
            });
            
        }
        else if(retVal==-1)
        {
            UIAlertView *msgListAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"Message list could not be retrieved"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [msgListAlert show];
                [msgListAlert release];
        }
        else if(retVal==0)
        {
            NSLog(@"retval is: %d",retVal);
            UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [connNullAlert show];
            [connNullAlert release];
        }
    });
}


-(void)showNewPosts
{
    NSLog(@"c1: %@",messageDataToShow);
    NSLog(@"c2: %@",userNameDataToShow);
    /*Reloead table view to display any newly fetched posts*/
    postsViewer=[[UITableView alloc]init];
    [postsViewer reloadData];
}

-(void)collectedPostData:(NSMutableArray *)inputArray
{
    [messagePostData addObjectsFromArray:[inputArray retain]];
    [messagePostData retain];
}

/*Setting the username received from loginView*/
-(void)getUserId:(NSString *)userId :(NSString *)userPassword
{
    userpwd=[[NSString alloc]init];
    username=[[NSString alloc]init];
    username=[userId retain];
    //userpwd=[userPassword retain];
    
    /*Signal userId to groupsTableView(to be used for new group creation*/
    groupViewObj=[[groupsTableViewViewController alloc]init];
    [groupViewObj getUserData:username :userpwd :userMailID];
    
    /*Signal userId to newPostView(to be used for new post creation*/
    newPostObj=[[newPostViewController alloc]init];
    [newPostObj getUserId:username];
}

/*Setting the userEmailID received from signupview*/
-(void)getUserMailID:(NSString *)mailID
{
    userMailID=[mailID retain];
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
        locationLatitude=locationLat;
        locationLongitude=locationLong;
        NSLog(@"Current user position: %@",showPos);
        
        /*Signal location co-ords to groupsTableView(to be used for new group creation)*/
        [groupViewObj getLocationCoords:latPos :longPos];
        
        /*Signal location co-ords to groupsTableView(to be used for new group creation)*/
        [newPostObj getLocationCoords:latPos :longPos];
        
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
    [messagePostData removeAllObjects];
    [friends removeAllObjects];
}

/*Show groups listing*/
-(IBAction)showGroups
{
    groupsBtn.enabled=FALSE;
    friendsBtn.enabled=FALSE;
    postBtn.enabled=FALSE;
    [restObj sendMessage:username :nil :nil :nil :nil :@"listMemberGroups"];
    double delayInSeconds = 2.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    retVal=[restObj returnValue];
    if(retVal==1)
    {
        groupsBtn.enabled=TRUE;
        friendsBtn.enabled=TRUE;
        postBtn.enabled=TRUE;
        groupsTableViewViewController *gTblView=[[groupsTableViewViewController alloc]initWithNibName:nil bundle:nil];
        [self presentViewController:gTblView animated:YES completion:NULL];
        [gTblView release];
    }
    else
    {
        groupsBtn.enabled=TRUE;
        friendsBtn.enabled=TRUE;
        postBtn.enabled=TRUE;
        UIAlertView *connErr=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [connErr show];
        [connErr release];
    }
    });
}

/*show friends listing */
-(IBAction)showFriends
{
    groupsBtn.enabled=FALSE;
    friendsBtn.enabled=FALSE;
    postBtn.enabled=FALSE;
    [restObj getFriendList:username :grpname :locationLatitude :locationLongitude :@"getUsersInGroup" ];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        retVal=[restObj returnValue];
        if(retVal==1)
        {
            groupsBtn.enabled=TRUE;
            friendsBtn.enabled=TRUE;
            postBtn.enabled=TRUE;
            friendsViewController *fTblView=[[friendsViewController alloc]initWithNibName:nil bundle:nil];
            [self presentViewController:fTblView animated:YES completion:NULL];
            [fTblView release];
        }
        else
        {
            groupsBtn.enabled=TRUE;
            friendsBtn.enabled=TRUE;
            postBtn.enabled=TRUE;
            UIAlertView *connErr=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [connErr show];
            [connErr release];
        }
    });
}

/*load view for new post*/
-(IBAction)createPost
{
    newPostViewController *newPostView=[[newPostViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:newPostView animated:YES completion:NULL];
    [newPostView release];
}

-(IBAction)stopUpdate
{
    [locManager stopUpdatingLocation];
    NSLog(@"Location updater stoppped.");
}

#pragma mark - Table view data source
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
    return [arr count];
 }
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"delegate 1 called..");
    if(messagePostData==NULL)
    {
        return 0;
    }
    else
    {
        return [messagePostData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"building cell");
    static NSString *CellIdentifier = @"PostsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (messageDataToShow!=NULL && userNameDataToShow!=NULL)
    {
        NSLog(@"from table: %@",[userNameDataToShow objectAtIndex:[indexPath row]]);
        NSLog(@"from table2: %@",[messageDataToShow objectAtIndex:[indexPath row]]);
        cell.textLabel.text=[userNameDataToShow objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text=[messageDataToShow objectAtIndex:[indexPath row]];
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end