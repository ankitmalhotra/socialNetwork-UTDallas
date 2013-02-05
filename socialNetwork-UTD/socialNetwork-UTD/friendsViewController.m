//
//  friendsViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 17/12/12.
//  Copyright (c) 2012 Ankit Malhotra. All rights reserved.
//

#import "friendsViewController.h"

@interface friendsViewController ()

@end

@implementation friendsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    messengerViewController *grabFriendObj=[[messengerViewController alloc] init];
    friendList=[grabFriendObj getFriendObjects:nil:0];
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
    messengerViewController *setIndexObj=[[messengerViewController alloc] init];
    [setIndexObj setSelectedIndex:selectedIndex];
    [self dismissViewControllerAnimated:YES completion:NULL];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)backToMain
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
