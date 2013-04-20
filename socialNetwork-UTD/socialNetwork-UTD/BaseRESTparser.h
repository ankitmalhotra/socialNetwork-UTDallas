//
//  BaseRESTparser.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "messengerViewController.h"
#import "loginViewController.h"
#import "messengerRESTclient.h"

/*use this forward declaration to avoid class parse issues*/
@class loginViewController;
@class messengerViewController;  /*Holds inbound service endpoint*/
@class messengerRESTclient;

static NSString *serviceEndPoint;

@interface BaseRESTparser : NSObject
{
    NSMutableArray	*_contentsOfElement;	// Contents of the current element
    messengerViewController *mainViewPtr;
    loginViewController *loginViewPtr;
    messengerRESTclient *callRESTclient;
}

- (id) init;
- (void) parseDocument:(NSData *)data :(NSString *)endPoint ;
- (void) clearContentsOfElement ;
- (void)callMain:(NSMutableArray *)mainContents;
- (NSArray *)dataExposer;
- (int)statusSignal;

@end
