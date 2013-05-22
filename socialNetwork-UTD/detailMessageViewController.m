//
//  detailMessageViewController.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 5/16/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "detailMessageViewController.h"

@implementation detailMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    postMessageView.text=_postMessageToDisp;
}

-(IBAction)backToMainView
{
    postMessageView.text=@"";
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getPostMessageToDisplay:(NSString *)postMessageToDisp
{
    _postMessageToDisp=[postMessageToDisp retain];
    NSLog(@"received: %@",_postMessageToDisp);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return NO;
}

@end
