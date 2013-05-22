//
//  userChatViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 4/30/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "userChatViewController.h"

static NSString *senderNumber;
static NSString *receiverNumber;


@interface userChatViewController ()

@end

@implementation userChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*Object Instantiations*/
    restObj=[[messengerRESTclient alloc]init];
    showAnimation=0;
    sendButton.enabled=FALSE;
    
    listOfMessages=[[NSMutableArray alloc]initWithObjects:nil, nil];
    chatTbView.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
    chatTbView.bubbleDataSource=self;
    chatTbView.snapInterval=120;
    chatTbView.showAvatars=YES;
    [chatTbView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title=_receiverName;
}

-(void)viewDidAppear:(BOOL)animated
{
    [chatTbView reloadData];
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [listOfMessages count];
    NSLog(@"num chat msgs: %lu",(unsigned long)[listOfMessages count]);
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [listOfMessages objectAtIndex:row];
}



/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listOfMessages count];
    NSLog(@"num chat msgs: %lu",(unsigned long)[listOfMessages count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    int idx=[indexPath row];
    cell.textLabel.text=[listOfMessages objectAtIndex:idx];
    NSString *detailField;
    detailField=localUserId;
    [detailField stringByAppendingString:@" says.."];
    cell.detailTextLabel.text=detailField;
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    
    return cell;
}
*/
 
 
/*
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
*/

-(IBAction)sendMessage
{
    chatTbView.typingBubble=NSBubbleTypingTypeNobody;
    
    backButton.enabled=FALSE;
    sendButton.enabled=FALSE;
    if(showAnimation>0 && ![messageField.text isEqual:@""])
    {
        double yOffset=toolbar.frame.origin.y;
        [UIView animateWithDuration:0.2f animations:^{
            toolbar.frame=CGRectMake(toolbar.frame.origin.x, yOffset+216, toolbar.frame.size.width, toolbar.frame.size.height);
        }];
        showAnimation=0;
    }
    else if(showAnimation==0 && [messageField.text isEqual:@""])
    {
        backButton.enabled=TRUE;
    }
    else
    {
        backButton.enabled=TRUE;
        sendButton.enabled=TRUE;
    }
    
    if(![messageField.text isEqual:@""])
    {
        [messageField resignFirstResponder];
        _chatMessage=[messageField.text retain];
        NSBubbleData *sayBubble=[NSBubbleData dataWithText:_chatMessage date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeMine];
        [listOfMessages addObject:sayBubble];
        [chatTbView reloadData];
        
        /*Place call to server with new post data & user,group,coord details*/
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"typed: %@",_chatMessage);
            [restObj chatMessage:senderNumber :receiverNumber :_chatMessage :@"postMessageToUser"];
            NSLog(@"calling for status from server..");
            retVal=[restObj returnValue];
            NSLog(@"status received:%d",retVal);
            if(retVal==1)
            {
                backButton.enabled=TRUE;
                sendButton.enabled=TRUE;
                //[self dismissViewControllerAnimated:YES completion:nil];
            }
            else if (retVal==0)
            {
                backButton.enabled=TRUE;
                sendButton.enabled=TRUE;
                
                UIAlertView *connNullAlert=[[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Unable to contact server" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [connNullAlert show];
                [connNullAlert release];
            }
            else if(retVal==-1)
            {
                backButton.enabled=TRUE;
                sendButton.enabled=TRUE;
                
                UIAlertView *createdAlert=[[UIAlertView alloc]initWithTitle:@"Failed" message:[NSString stringWithFormat:@"New Message could not be posted"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [createdAlert show];
                [createdAlert release];
            }
        });
        /*
        double delayInSeconds = 2.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    });
        */
        messageField.text=@"";
    }
}

-(void)showNewMessage:(NSString *)chatMessage :(NSString *)senderName
{
    NSLog(@"notification from: %@",senderName);
    NSLog(@"notification is: %@",chatMessage);
    NSBubbleData *sayBubble=[NSBubbleData dataWithText:chatMessage date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeSomeoneElse];
    [listOfMessages addObject:sayBubble];
    NSLog(@"count is: %d",[listOfMessages count]);
    NSLog(@"bubble payload is: %@",listOfMessages);

    [chatTbView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[listOfMessages count] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    //[self viewDidAppear:YES];
    [chatTbView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[listOfMessages count]-1 inSection:0] atScrollPosition:UITableViewRowAnimationTop animated:YES];
}

-(IBAction)touchInsideTextField
{
    if (showAnimation==0)
    {
        sendButton.enabled=TRUE;
        double yOffset=toolbar.frame.origin.y;
        [UIView animateWithDuration:0.5 animations:^{
            toolbar.frame=CGRectMake(toolbar.frame.origin.x, yOffset-216, toolbar.frame.size.width, toolbar.frame.size.height);
        }];
        showAnimation++;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(![textField.text isEqual:@""])
    {
        sendButton.enabled=TRUE;
    }
}

-(IBAction)backToFriendsView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getUserId:(NSString *)userId
{
    localUserId =[userId retain];
}

-(void)getUserNumber:(NSString *)userNum
{
    senderNumber=[userNum retain];
    NSLog(@"user number at chat window: %@",senderNumber);
}

-(void)getReceiverName: (NSString *)receiverName
{
    _receiverName=receiverName;
}

-(void)getReceiverNumber:(NSString *)receiverNum
{
    receiverNumber=[receiverNum retain];
    NSLog(@"receiver number to be used: %@",receiverNumber);
}

-(IBAction)backgroundTouched:(id)sender
{
    [messageField resignFirstResponder];
}

-(BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
