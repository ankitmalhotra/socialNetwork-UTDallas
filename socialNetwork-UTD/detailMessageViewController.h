//
//  detailMessageViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 5/16/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailMessageViewController : UIViewController
{
    IBOutlet UIBarButtonItem *backButton;
    IBOutlet UITextView *postMessageView;
    NSString *_postMessageToDisp;
}

-(IBAction)backToMainView;
-(void)getPostMessageToDisplay: (NSString *)postMessageToDisp;

@end
