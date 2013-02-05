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
    //restObj=[[messengerRESTclient alloc]init];
    //[restObj receiveMessage:@"list"];
    messengerViewController *grabGroupsObj=[[messengerViewController alloc] init];
    /*Call to retrieve the collated data from server*/
    groupList=[grabGroupsObj setGroupObjects:nil :0];
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
    messengerViewController *setIndexObj=[[messengerViewController alloc] init];
    [setIndexObj setSelectedIndex:selectedIndex];
    [self dismissViewControllerAnimated:YES completion:NULL];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(IBAction)backToMain
{
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
        UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Success" message:[NSString stringWithFormat:@"New Group Successfully created"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [createdAlert show];
        [createdAlert release];
    }
}


-(BOOL)shouldAutorotate
{
    return NO;
}


@end
