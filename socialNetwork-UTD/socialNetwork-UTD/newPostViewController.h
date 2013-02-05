//
//  newPostViewController.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 01/01/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messengerViewController.h"

@interface newPostViewController : UIViewController
{    
    IBOutlet UIBarButtonItem *cancelButton;
    IBOutlet UITextView *messageVw;
    IBOutlet UIBarButtonItem *postButton;
    
}

-(IBAction)createNewPost;
-(IBAction)backToMain;

@end
