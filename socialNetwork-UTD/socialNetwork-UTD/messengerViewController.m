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
//#import <MapKit/MapKit.h>
#define kGeoCodingString @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"

@interface messengerViewController ()
{
    /*Location constants*/
    CLLocationManager *locManager;
    CLLocation *currLocation;
    //SecKeyRef *kRef;
    
    /*XML Parser constants*/
    NSXMLParser *xmlParser;
	NSMutableData *webData;
	NSMutableString *soapResults;
	BOOL recordResults;
    
    
    /*Login View constants*/
    /*
    UIAlertView *loginView;
    UITextField *loginUsernameField;
    UITextField *loginPassworField;
    UILabel *loginUserNameLabel;
    UILabel *loginPasswordLabel;
    */

    
    /*Crypto Buffers*/
    size_t cipherBufferSize;
    uint8_t *cipherBuffer;
    size_t plainBufferSize;
    uint8_t *plainBuffer;
    
    /*User credentials*/
    NSString *username;
    NSString *userPwd;
    
    NSString *selectedIndex;
    
    
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




/*SOAP request call
-(void)processRequest
{

    GroupsDataServiceServiceSoap11Binding *bindingSOAP=[GroupsDataServiceServiceSvc GroupsDataServiceServiceSoap11Binding];
    GroupsDataServiceServiceSoap11BindingResponse *bindingResponse;
    GroupsDataServiceServiceSvc_GetGroupsData *request=[[GroupsDataServiceServiceSvc_GetGroupsData alloc]init];
    request.UserId=username;
    bindingResponse=[bindingSOAP GetGroupsDataUsingParameters:request];
    NSLog(@"done processing request.. %@",bindingResponse);
    NSLog(@"at server: %@",request.UserId);
    dispatch_async(dispatch_get_main_queue(), ^{[self processResponse:bindingResponse];});
}
*/

/*SOAP response call
-(void)processResponse:(testGreetPortBindingResponse *)response
{
    NSArray *responseBodyParts = response.bodyParts;
    NSLog(@"bodyparts: %@",responseBodyParts);
    id bodyPart;
    @try
    {
        bodyPart = [responseBodyParts objectAtIndex:0]; // Assuming just 1 part in response which is fine
        NSLog(@"type is: %@",bodyPart);
    }
    @catch (NSException* exception)
    {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Server Error" message:@"Error while trying to process request" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([bodyPart isKindOfClass:[SOAPFault class]])
    {
        NSString* errorMesg = ((SOAPFault *)bodyPart).simpleFaultString;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Server Error" message:errorMesg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else if([bodyPart isKindOfClass:[GroupsDataServiceServiceSvc_GetGroupsDataResponse class]])
    {
        GroupsDataServiceServiceSvc_GetGroupsDataResponse* groupResponse = bodyPart;
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Success!" message:[NSString stringWithFormat:@"Response data is %@",groupResponse.return_] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];        
    }
}
*/




/*Define group values to be shown in group tableview*/
-(NSMutableArray *)setGroupObjects:(NSMutableArray *)arrayInput:(int)toReturn
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
-(NSArray *)getFriendObjects:(NSMutableArray *)arrayInput:(int)toReturn
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


/*Receive the index selected in any tableview*/
-(void)setSelectedIndex:(NSString *)indexVal
{
    selectedIndex=indexVal;
    NSLog(@"index selected: %@",selectedIndex);
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

/*show groups listing*/
-(IBAction)showGroups
{
    groupsTableViewViewController *gTblView=[[groupsTableViewViewController alloc]initWithNibName:nil bundle:nil];
    [self presentViewController:gTblView animated:YES completion:NULL];
    
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