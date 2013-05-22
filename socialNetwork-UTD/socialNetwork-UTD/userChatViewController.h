//
//  userChatViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 4/30/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerRESTclient.h"
#import "UIBubbleTableViewDataSource.h"
#import "UIBubbleTableView.h"
#import "NSBubbleData.h"


@class messengerRESTclient;

@interface userChatViewController : UIViewController<UITextFieldDelegate,UIBubbleTableViewDataSource>
{
    IBOutlet UIBarButtonItem *sendButton;
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UITextField *messageField;
    IBOutlet UIToolbar *toolbar;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIBubbleTableView *chatTbView;
    int retVal;
    int showAnimation;
    NSMutableArray *listOfMessages;
    
    NSString *_chatMessage;
    NSString *localUserId;
    NSString *_receiverName;
    messengerRESTclient *restObj;
}

-(IBAction)sendMessage;
-(IBAction)backToFriendsView;
-(IBAction)touchInsideTextField;
-(void)showNewMessage: (NSString *)chatMessage : (NSString *)senderName;
-(void)getUserNumber: (NSString *)userNum;
-(void)getUserId: (NSString *)userId;
-(void)getReceiverNumber: (NSString *)receiverNum;
-(void)getReceiverName: (NSString *)receiverName;


@end
