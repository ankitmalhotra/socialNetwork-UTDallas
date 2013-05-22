//
//  groupsTableViewViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "groupsTableViewViewController.h"

static double locationLat,locationLong;
static NSString *localUserId;
static NSString *localUserNumber;
static NSString *localUserPwd;
static NSString *localUserEmailID;
static NSString *selectedGroupName;
static NSMutableArray *groupList;
static NSMutableArray *friendsReceived;
static int viewCounter=0;

@interface groupsTableViewViewController ()

@end

@implementation groupsTableViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Init all objects to be used*/
    mainViewObj=[[messengerViewController alloc] init];
    restObj=[[messengerRESTclient alloc]init];
    newPostObj=[[newPostViewController alloc]init];
    
    connProgress.transform=CGAffineTransformMakeScale(1.5, 1.5);
    refreshCntl=[[UIRefreshControl alloc]init];
    [refreshCntl addTarget:self action:@selector(refreshUI)forControlEvents:UIControlEventAllEvents];
    [tabVw addSubview:refreshCntl];
    
    /*Init loc-update to get the latest coordinates*/
    [mainViewObj initLocUpdate];
    
    /*Call to retrieve the collated data from server*/
    groupList=[mainViewObj getGroupObjects:nil :0];
}

-(void)viewDidAppear:(BOOL)animated
{
    /*Reload table view with updated data*/
    NSLog(@"userId being used %@",localUserId);

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tabVw reloadData];
    });
}


-(void)refreshUI
{
    addGrp.enabled=FALSE;
    backToMain.enabled=FALSE;
    showAll.enabled=FALSE;
    
    if(viewCounter==0)
    {
        viewCounter=1;
    }
    else if (viewCounter==1)
    {
        viewCounter=0;
    }
    
    /*Reload table view with updated data*/
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tabVw reloadData];
    });
    
    [refreshCntl endRefreshing];
    
    addGrp.enabled=TRUE;
    backToMain.enabled=TRUE;
    showAll.enabled=TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [countries count];
    return [arr count];
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groupList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    selectedGroupName=[groupList objectAtIndex:[indexPath row]];
    cell.textLabel.text=selectedGroupName;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    selectedGroupName=[groupList objectAtIndex:[indexPath row]];
    dispatch_async(dispatch_get_main_queue(), ^{
        connProgress.hidden=FALSE;
        [connProgress startAnimating];
        
        addGrp.enabled=FALSE;
        backToMain.enabled=FALSE;
        showAll.enabled=FALSE;
        [tabVw setUserInteractionEnabled:FALSE];
        NSLog(@"x3: %@",localUserId);
        [restObj getFriendList:localUserId :selectedGroupName :locationLat:locationLong :@"getUsersInGroup"];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            retval=[restObj returnValue];
            if(retval==1)
            {
                friendsReceived=[mainViewObj signalFriends];
                if([friendsReceived containsObject:localUserNumber])
                {
                    [mainViewObj setSelectedIndex:selectedGroupName];
                    
                    [connProgress stopAnimating];
                    connProgress.hidden=TRUE;
                    [tabVw setUserInteractionEnabled:TRUE];
                    
                    [mainViewObj clearBufferList];
                    [mainViewObj clearAllPosts];
                    [self dismissViewControllerAnimated:YES completion:NULL];
                }
                else
                {
                    UIAlertView *joinAlert=[[UIAlertView alloc]initWithTitle:@"Join this group ?" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                    [joinAlert show];
                    [joinAlert release];
                }
            }
        });
    });
    
    
    /*
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            });
     */
}

-(IBAction)backToMain
{
    /*Call to main to clear buffer holding group list and then dismiss view*/
    [mainViewObj clearBufferList];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [mainViewObj release];
}


-(IBAction)createGroup
{
    UIAlertView *createAlert=[[UIAlertView alloc]initWithTitle:@"New Group" message:[NSString stringWithFormat:@"Enter the group name"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    /*Add the text-field for group name*/
    groupNameField=[[UITextField alloc]initWithFrame:CGRectMake(32.0,45.0,220.0,25.0)];
    groupNameField.placeholder=@"Group Name";
    [groupNameField setBackgroundColor:[UIColor whiteColor]];
    [createAlert addSubview:groupNameField];
    
    CGAffineTransform createAlertTrans=CGAffineTransformMakeTranslation(0.0, -80.0);
    [createAlert setTransform:createAlertTrans];
    [createAlert show];
    
    [createAlert release];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if([alertView.title isEqual:@"Join this group ?"])
        {
            /*Call the join group endpoint*/
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"x4: %@",localUserId);
               [restObj joinGroup:localUserId :selectedGroupName :locationLat :locationLong :@"joinGroup"];
                NSLog(@"calling for status from server..");
                retval=[restObj returnValue];
                if(retval==1)
                {
                    [mainViewObj setSelectedIndex:selectedGroupName];
                    [mainViewObj clearBufferList];
                    [mainViewObj clearAllPosts];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    [connProgress stopAnimating];
                    connProgress.hidden=TRUE;
                    
                    [self dismissViewControllerAnimated:YES completion:NULL];
                }
                else if(retval==-1)
                {
                    UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"Could not join the group"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    [connProgress stopAnimating];
                    connProgress.hidden=TRUE;
                }
                else if(retval==0)
                {
                    UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [connNullAlert show];
                    [connNullAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    [connProgress stopAnimating];
                    connProgress.hidden=TRUE;
                }

            });
            
            /*
            double delayInSeconds = 2.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             
            });
             */
        }
        else if([alertView.title isEqual:@"New Group"])
        {
            addGrp.enabled=FALSE;
            backToMain.enabled=FALSE;
            showAll.enabled=FALSE;
            
            connProgress.hidden=FALSE;
            [connProgress startAnimating];
            [tabVw setUserInteractionEnabled:FALSE];
            
            /*Capture entered group name*/
            newGroupName=groupNameField.text;
            NSLog(@"group name is: %@",newGroupName);
            
            /*Place call to server to store new group details*/
            NSLog(@"userid check: %@",localUserId);
            NSLog(@"coords lat check: %f",locationLat);
            NSLog(@"coords long check: %f",locationLong);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"x5: %@",localUserId);
                [restObj createGroup:localUserId :newGroupName :locationLat :locationLong :@"addGroup"];
                NSLog(@"calling for status from server..");
                retval=[restObj returnValue];
                if(retval==1)
                {
                    UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"New Group Successfully created"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                    
                    /*Refresh table view with updated data*/
                    if(viewCounter==0)
                    {
                        viewCounter=1;
                    }
                    else if (viewCounter==1)
                    {
                        viewCounter=0;
                    }

                    [self showAllGroups];
                    [self refreshUI];
                }
                else if(retval==-1)
                {
                    UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"New Group could not be created"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                }
                else if(retval==0)
                {
                    UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [connNullAlert show];
                    [connNullAlert release];
                }
            });
            
            /*
            double delayInSeconds = 2.3;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            });
             */
        }
    }
    else if(buttonIndex==0)
    {
        [tabVw setUserInteractionEnabled:TRUE];
        connProgress.hidden=TRUE;
        [connProgress stopAnimating];
        addGrp.enabled=TRUE;
        backToMain.enabled=TRUE;
        showAll.enabled=TRUE;
    }
}


-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude
{
    locationLat=locationLatitude;
    locationLong=locationLongitude;
    NSLog(@"received coords: lat: %f ,long: %f",locationLat,locationLong);
}

-(void)getUserNumber: (NSString *)userNum;
{
    localUserNumber=[userNum retain];
    NSLog(@"received userNumber: %@",localUserNumber);
}

-(void)getUserData: (NSString *)userId :(NSString *)userPwd :(NSString *)userEmailID
{
    
    //localUserNumber=[userNum retain];
    localUserId=[userId retain];
    localUserPwd=[userPwd retain];
    localUserEmailID=[userEmailID retain];
    NSLog(@"received userId: %@",localUserId);
    NSLog(@"received userPwd: %@",localUserPwd);
    NSLog(@"received userEmailID: %@",localUserEmailID);
}


-(void)showAllGroups
{
    addGrp.enabled=FALSE;
    backToMain.enabled=FALSE;
    showAll.enabled=FALSE;
    connProgress.hidden=FALSE;
    [connProgress startAnimating];
    [tabVw setUserInteractionEnabled:FALSE];
    
    if(viewCounter==0)
    {
        [groupList removeAllObjects];
        
        //fetchMyGroupsQueue=dispatch_queue_create("fetchMyGroups", NULL);
        NSLog(@"x1: %@",localUserId);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [restObj showAllGroups:localUserId :localUserPwd :localUserEmailID :locationLat :locationLong :@"showGroups"];
            });
            
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             
                NSLog(@"calling for status from server..");
                retval=[restObj returnValue];
                if(retval==1)
                {
                    viewCounter=1;
                    
                    showAll.title=@"Show my Groups";
                    [tabVw reloadData];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                }
                else if(retval==-1)
                {
                    UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Groups could not be fetched for you at this time"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                    showAll.title=@"Show groups near me";
                    
                    viewCounter=0;
                }
                else if(retval==0)
                {
                    UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [connNullAlert show];
                    [connNullAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                    showAll.title=@"Show groups near me";
                    
                    viewCounter=0;
                } 
            });
        /*Reload table view with updated data
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [tabVw reloadData];
        });
         */
        /*
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        });  
         */
    }
    else if (viewCounter==1)
    {
        [groupList removeAllObjects];
        
        //fetchOtherGroupsQueue=dispatch_queue_create("fetchOtherGroups", NULL);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"x2: %@",localUserId);
            [restObj sendMessage:localUserId :nil :nil :nil :nil :@"listMemberGroups"];
        });
        
            double delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
             
                NSLog(@"calling for status from server..");
                retval=[restObj returnValue];
                if(retval==1)
                {
                    viewCounter=0;
                    [tabVw reloadData];

                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    showAll.title=@"Show groups near me";
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                }
                else if(retval==-1)
                {
                    UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Groups could not be fetched for you at this time"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                    showAll.title=@"Show my Groups";
                    
                    viewCounter=1;
                }
                else if(retval==0)
                {
                    UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [connNullAlert show];
                    [connNullAlert release];
                    
                    [tabVw setUserInteractionEnabled:TRUE];
                    connProgress.hidden=TRUE;
                    [connProgress stopAnimating];
                    addGrp.enabled=TRUE;
                    backToMain.enabled=TRUE;
                    showAll.enabled=TRUE;
                    showAll.title=@"Show my Groups";
                    
                    viewCounter=1;
                }
        });
        /*Reload table view with updated data
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [tabVw reloadData];
        });
        */
        /*
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        });
         */
    }
}



-(BOOL)shouldAutorotate
{
    return NO;
}


@end
