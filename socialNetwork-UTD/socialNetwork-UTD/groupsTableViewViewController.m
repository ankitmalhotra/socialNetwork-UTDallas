//
//  groupsTableViewViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 04/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "groupsTableViewViewController.h"

@interface groupsTableViewViewController ()

@end

@implementation groupsTableViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    /*Init all objects to be used*/
    grabGroupsObj=[[messengerViewController alloc] init];
    setIndexObj=[[messengerViewController alloc]init];
    restObj=[[messengerRESTclient alloc]init];
    newPostObj=[[newPostViewController alloc]init];
    
    refreshCntl=[[UIRefreshControl alloc]init];
    [refreshCntl addTarget:self action:@selector(refreshUI)forControlEvents:UIControlEventValueChanged];
    
    /*Call to retrieve the collated data from server*/
    groupList=[grabGroupsObj getGroupObjects:nil :0];
}

-(void)refreshUI
{
    NSLog(@"refreshing..");
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
    
    selectedIndex=[groupList objectAtIndex:[indexPath row]];
    cell.textLabel.text=selectedIndex;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex=[groupList objectAtIndex:[indexPath row]];
    [setIndexObj setSelectedIndex:selectedIndex];
    [grabGroupsObj clearBufferList];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [grabGroupsObj showNewPosts];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)backToMain
{
    /*Call to main to clear buffer holding group list and then dismiss view*/
    [grabGroupsObj clearBufferList];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(IBAction)createGroup
{
    UIAlertView *createAlert=[[UIAlertView alloc]initWithTitle:@"New Group" message:[NSString stringWithFormat:@"Enter the group name"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    /*
    double xCoord=(createAlert.frame.origin.x);
    double yCoord=(createAlert.frame.origin.y);
    double width=(createAlert.frame.size.width);
    double height=(createAlert.frame.size.height);
    */
    
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
        /*Capture entered group name*/
        grpName=groupNameField.text;
        NSLog(@"group name is: %@",grpName);
        
        /*Place call to server to store new group details*/
        NSLog(@"userid check: %@",localUserId);
        NSLog(@"coords lat check: %f",locationLat);
        NSLog(@"coords long check: %f",locationLong);

        [restObj createGroup:localUserId :grpName :locationLat :locationLong :@"addGroup"];
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            NSLog(@"calling for status from server..");
            retval=[restObj returnValue];
            if(retval==1)
            {
                UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"New Group Successfully created"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [createdAlert show];
                    [createdAlert release];
                [self dismissViewControllerAnimated:YES completion:nil];
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
    }
}


-(void)getLocationCoords:(double)locationLatitude :(double)locationLongitude
{
    locationLat=locationLatitude;
    locationLong=locationLongitude;
    NSLog(@"received coords: lat: %f ,long: %f",locationLat,locationLong);
}

-(void)getUserData:(NSString *)userId :(NSString *)userPwd :(NSString *)userEmailID
{
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
    [restObj showAllGroups:localUserId :localUserPwd :localUserEmailID :locationLat :locationLong :@"showGroups"];
    double delayInSeconds = 2.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"calling for status from server..");
        retval=[restObj returnValue];
        if(retval==1)
        {
            /*Reload table view with updated data*/
            [tabVw reloadData];
            
            addGrp.enabled=TRUE;
            backToMain.enabled=TRUE;
            showAll.enabled=TRUE;
        }
        else if(retval==-1)
        {
            UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:[NSString stringWithFormat:@"Groups could not be fetched for you at this time"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [createdAlert show];
            [createdAlert release];
            addGrp.enabled=TRUE;
            backToMain.enabled=TRUE;
            showAll.enabled=TRUE;
        }
        else if(retval==0)
        {
            UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [connNullAlert show];
            [connNullAlert release];
            addGrp.enabled=TRUE;
            backToMain.enabled=TRUE;
            showAll.enabled=TRUE;
        }
    });
}


-(BOOL)shouldAutorotate
{
    return NO;
}


@end
