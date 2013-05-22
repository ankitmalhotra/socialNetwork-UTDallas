//
//  friendsViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 17/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "friendsViewController.h"

static NSMutableArray *friendNumber;


@implementation friendsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Object instantiations*/
    mainViewObj=[[messengerViewController alloc] init];
    
    refreshControl=[[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshUI) forControlEvents:UIControlEventValueChanged];
    [tabVw addSubview:refreshControl];
    
    /*Call to retrieve the collated data from server*/
    friendList=[mainViewObj getFriendObjects:nil:0];
    NSLog(@"friends got: %@",friendList);
    friendDictionary=[[NSDictionary alloc]initWithObjects:friendNumber forKeys:friendList];
}

-(void)viewDidAppear:(BOOL)animated
{
    [tabVw reloadData];
}

-(void)refreshUI
{
    [tabVw reloadData];
    [refreshControl endRefreshing];
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [friendList count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[friendList allKeys] objectAtIndex:section];
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is not good: %d",[friendList count]);
    return [friendList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    selectedIndex=[friendList objectAtIndex:[indexPath row]];
    cell.textLabel.text=selectedIndex;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedIndex=[friendList objectAtIndex:[indexPath row]];
    
    [mainViewObj setSelectedIndexFriends:selectedIndex];
    [mainViewObj clearBufferList];
    
    NSLog(@"number of selected friend is: %@",[friendDictionary objectForKey:selectedIndex]);
    userChatObj=[[userChatViewController alloc]initWithNibName:nil bundle:nil];
    [userChatObj getReceiverNumber:[friendDictionary objectForKey:selectedIndex]];
    [userChatObj getReceiverName:selectedIndex];
    [self presentViewController:userChatObj animated:YES completion:nil];
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)getFriendNumbers:(NSMutableArray *)friendNum
{
    friendNumber=[friendNum retain];
    NSLog(@"friend nums: %@",friendNumber);
}

-(IBAction)backToMain
{
    [mainViewObj clearBufferList];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [mainViewObj release];
}


-(BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
