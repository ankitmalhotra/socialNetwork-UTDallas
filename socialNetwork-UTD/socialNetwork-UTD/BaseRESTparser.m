//
//  BaseRESTparser.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "BaseRESTparser.h"

@implementation BaseRESTparser

    - (id) init
    {
        self = [super init];
        return self;
    }

   /*Clear the contents of the collected inter-element text*/
    - (void) clearContentsOfElement
    {
        [_contentsOfElement release];
    }

    /*Start the parsing process*/
    - (void) parseDocument:(NSData *) data:(NSString *)endPoint
    {
        serviceEndPoint=endPoint;
        mainViewPtr=[[messengerViewController alloc]init];
        NSLog(@"data in: %@",data);
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        [parser setDelegate:self];
        /*Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser*/
        [parser setShouldProcessNamespaces:YES];
        [parser setShouldReportNamespacePrefixes:YES];
        [parser setShouldResolveExternalEntities:NO];
        
        [parser parse];
        
        [parser release];
    }

    /*Handle the receipt of intraelement text*/
    - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
    {
        NSLog(@"string in: %@",string);
        _contentsOfElement=[NSMutableArray arrayWithObjects:string, nil];
        NSLog(@"contents buid: %@",_contentsOfElement);
        [self callMain:_contentsOfElement];
    }

   /*Manage call to main view and send the parsed data*/
    -(void)callMain:(NSMutableArray *)mainContents
    {
        if(serviceEndPoint==@"add")
        {
           /*point to add response handler in mainView*/
        }
        else if(serviceEndPoint==@"login")
        {
           /*point to login response handler in mainView*/
        }
        else if(serviceEndPoint==@"list")
        {
          NSLog(@"calling friends with: %@",mainContents);
          [mainViewPtr getFriendObjects:mainContents :1];  
        }
      //[mainViewPtr setGroupObjects:mainContents:1];
    }

    -(NSArray *)dataExposer
    {
        return _contentsOfElement;
    }

    -(int)statusSignal
    {
        return 1;
    }

    /*Trim leading and trailing spaces*/
    - (NSString *)trim:(NSString *)inStr
    {
        return [inStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    - (void) dealloc
    {
        [_contentsOfElement release];
        [super dealloc];
    }

@end
