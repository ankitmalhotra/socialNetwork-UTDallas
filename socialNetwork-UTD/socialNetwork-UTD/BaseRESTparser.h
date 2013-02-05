//
//  BaseRESTparser.h
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "messengerViewController.h"

@class messengerViewController;  /*use this forward declaration to avoid class parse issues*/
/*Holds inbound service endpoint*/
static NSString *serviceEndPoint;

@interface BaseRESTparser : NSObject
{
    NSMutableArray	*_contentsOfElement;	// Contents of the current element
    messengerViewController *mainViewPtr;
}

- (id) init;
- (void) parseDocument:(NSData *) data:(NSString *)endPoint ;
- (void) clearContentsOfElement ;
- (void)callMain:(NSArray *)mainContents;
- (NSArray *)dataExposer;
- (int)statusSignal;

@end
