//
//  messengerRESTclient.m
//  socialNetwork-UTD
//
//  Created by Ankit Malhotra on 1/20/13.
//  Copyright (c) 2013 Ankit Malhotra. All rights reserved.
//

#import "messengerRESTclient.h"

@implementation messengerRESTclient

/*Using this function for handling asynchronous GET calls*/
-(void)receiveMessage:(NSString *)endPoint
{
    serviceEndPoint=endPoint;
    NSLog(@"receiveMessage in..");
    NSString *settingsBundle=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"settings found");
    }
    else
    {
        NSLog(@"settings missing..");
    }
    
    NSDictionary *settings=[NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *prefrences=[settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister=[[NSMutableDictionary alloc]initWithCapacity:[prefrences count]];
    
    for(NSDictionary *prefSpecs in prefrences)
    {
        NSString *key=[prefSpecs objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecs objectForKey:@"DefaultValue"] forKey:key];
        }
        else
        {
            NSLog(@"key not found..");
        }
    }
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *urlString=[defaults stringForKey:@"server_url"];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/v2/%@",urlString,endPoint]];
    NSLog(@"Sending Request to URL %@", url);

    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReloadIgnoringCacheData
									 timeoutInterval:30.0];
    
    /*start the async request*/
	[NSURLConnection connectionWithRequest:request delegate:self];
}







- (void)_startReceive
// Starts a connection to download the current URL.
{
    BOOL                success;
    NSURL *             url;
    NSMutableURLRequest *      request;
    
    //assert(connection == nil);         // don't tap receive twice in a row!
    //assert(currentChallenge == nil);   // ditto
    //assert(earlyTimeoutTimer == nil);  // ditto
    
    // First get and check the URL.
    
    url = [[messengerAppDelegate sharedAppDelegate] smartURLForString:@"https://appserver.utdallas.edu:8443/REST/v1/micceo"];
    success = (url != nil);
    NSLog(@"%@",url);
    // If the URL is bogus, let the user know.  Otherwise kick off the connection.
    
    if ( ! success) {
        [self _updateStatus:@"Invalid URL"];
    } else {
        
        // Open a stream for the file we're going to receive into.
        
        
        // Open a connection for the URL.
        
        //request=[NSURLRequest requestWithURL:url];
        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
        [request setHTTPMethod:@"POST"];

        [NSURLConnection connectionWithRequest:request delegate:self];
        /*
        NSError			*requestError;
        NSURLResponse	*urlResponse;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                     returningResponse:&urlResponse
                                                                 error:&requestError];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
        int status = [httpResponse statusCode];
        NSLog(@"Request: %@",urlResponse);
        NSLog(@"status error: %d and %@",status,httpResponse);
        NSLog(@"data: %@",responseData);
        */
        
        //connection = [NSURLConnection connectionWithRequest:request delegate:self];
        //assert(connection != nil);
        
        // If we've been told to use an early timeout for debugging purposes,
        // set that up now.
        /*
        if ([DebugOptions sharedDebugOptions].earlyTimeout) {
            earlyTimeoutTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(_earlyTimeout:) userInfo:nil repeats:NO];
            assert(earlyTimeoutTimer != nil);
        }
        */
        // Tell the UI we're receiving.
        
        //[self _receiveDidStart];
    }
}

- (void)_receiveDidStart
{
    // Clear the current image so that we get a nice visual cue if the receive fails.
    [[messengerAppDelegate sharedAppDelegate] didStartNetworking];
}


-(int)createNewPost:(NSString *)userID :(NSString *)groupName :(NSString *)postData :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL
{
    NSLog(@"userid: %@",userID);
    NSLog(@"grp name: %@",groupName);
    NSLog(@"postdata: %@",postData);
    NSLog(@"lat: %f",locationLatitude);
    NSLog(@"long: %f",locationLongitude);
    NSLog(@"endpoint: %@",endPointURL);


    int retVal;
    serviceEndPoint=endPointURL;
    
    NSString *settingsBundle=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"settings found");
    }
    else
    {
        NSLog(@"settings missing..");
    }
    
    NSDictionary *settings=[NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *prefrences=[settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister=[[NSMutableDictionary alloc]initWithCapacity:[prefrences count]];
    
    for(NSDictionary *prefSpecs in prefrences)
    {
        NSString *key=[prefSpecs objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecs objectForKey:@"DefaultValue"] forKey:key];
        }
        else
        {
            NSLog(@"key not found..");
        }
    }
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *urlString=[defaults stringForKey:@"server_url"];
    
    NSURL *url=[[messengerAppDelegate sharedAppDelegate]smartURLForString:[NSString stringWithFormat:@"%@/v1/%@",urlString,endPointURL]];
    
    NSLog(@"Sending Request to URL %@", url);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSString *contentType=[NSString stringWithFormat:@"application/XML"];
    [request addValue:contentType forHTTPHeaderField:@"Content-type"];
    
    /*Build the XML structure to send*/
    if([endPointURL isEqualToString:@"postMessage"])
    {
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<Message xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserId>%@</UserId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<GroupName>%@</GroupName>",groupName]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<MessageData>%@</MessageData>",postData]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserLocationLat>%f</UserLocationLat>",locationLatitude]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserLocationLong>%f</UserLocationLong>",locationLongitude]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</Message>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
        NSLog(@"passing xml: %@",postData);
    }
    
    /*Handle the synchronous response here*/
    NSError			*requestError;
	NSURLResponse	*urlResponse;
	NSError			*error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request
												 returningResponse:&urlResponse
															 error:&requestError];
	if (error == nil)
    {
		if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]])
        {
			NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
			/*If the call was okay, then invoke the parser*/
			if ((status >= 200) && (status < 300))
            {
                NSLog(@"sending parse request with: %@",responseData);
                accessPtr = [[BaseRESTparser alloc]init];
                NSLog(@"parsing for: %@",endPointURL);
                NSString *xml = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                NSLog(@"xml for: %@ = %@",endPointURL,xml);
                [xml release];
				[accessPtr parseDocument:responseData:endPointURL];
                retVal=1;
			}
            else
            {
                NSLog(@"status error: %d and %@",status,httpResponse);
                retVal=0;
            }
		}
        else
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
            NSLog(@"Unable to complete the request: %@",urlResponse);
            NSLog(@"status error: %d and %@",status,httpResponse);
            retVal=0;
        }
	}
    else
    {
        retVal=0;
    }
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return retVal;
}


/*This block places request to server to create a new group based on input received from groupsTableView*/
-(int)createGroup:(NSString *)userID :(NSString *)groupName :(double)locationLatitude :(double)locationLongitude :(NSString *)endPointURL
{
    int retVal;
    serviceEndPoint=endPointURL;
    
    NSString *settingsBundle=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"settings found");
    }
    else
    {
        NSLog(@"settings missing..");
    }
    
    NSDictionary *settings=[NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *prefrences=[settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister=[[NSMutableDictionary alloc]initWithCapacity:[prefrences count]];
    
    for(NSDictionary *prefSpecs in prefrences)
    {
        NSString *key=[prefSpecs objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecs objectForKey:@"DefaultValue"] forKey:key];
        }
        else
        {
            NSLog(@"key not found..");
        }
    }
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *urlString=[defaults stringForKey:@"server_url"];
    
    NSURL *url=[[messengerAppDelegate sharedAppDelegate]smartURLForString:[NSString stringWithFormat:@"%@/v1/%@",urlString,endPointURL]];
    
    NSLog(@"Sending Request to URL %@", url);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSString *contentType=[NSString stringWithFormat:@"application/XML"];
    [request addValue:contentType forHTTPHeaderField:@"Content-type"];
    
    /*Build the XML structure to send*/
    if([endPointURL isEqualToString:@"addGroup"])
    {
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<Group xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<GroupName>%@</GroupName>",groupName]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<GroupLocationLat>%f</GroupLocationLat>",locationLatitude]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<GroupLocationLong>%f</GroupLocationLong>",locationLongitude]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<GroupOwnerId>%@</GroupOwnerId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</Group>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
    }
    
    /*Handle the synchronous response here*/
    NSError			*requestError;
	NSURLResponse	*urlResponse;
	NSError			*error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request
												 returningResponse:&urlResponse
															 error:&requestError];
	if (error == nil)
    {
		if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]])
        {
			NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
			/*If the call was okay, then invoke the parser*/
			if ((status >= 200) && (status < 300))
            {
                NSLog(@"sending parse request with: %@",responseData);
                accessPtr = [[BaseRESTparser alloc]init];
                NSLog(@"parsing for: %@",endPointURL);
                NSString *xml = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                NSLog(@"xml for: %@ = %@",endPointURL,xml);
                [xml release];
				[accessPtr parseDocument:responseData:endPointURL];
                retVal=1;
			}
            else
            {
                NSLog(@"status error: %d and %@",status,httpResponse);
                retVal=0;
            }
		}
        else
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
            NSLog(@"Unable to complete the request: %@",urlResponse);
            NSLog(@"status error: %d and %@",status,httpResponse);
            retVal=0;
        }
	}
    else
    {
        retVal=0;
    }
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return retVal;

}



/*Using this function for handling synchronous POST calls for login, signup
 & listing groups*/
-(int)sendMessage:(NSString *)userID :(NSString *)userName :(NSString *)password :(NSString *)emailID :(NSString *)endPointURL
{
    NSLog(@"sendMessage in..");
    
    int retVal;
    serviceEndPoint=endPointURL;

    NSString *settingsBundle=[[NSBundle mainBundle]pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle)
    {
        NSLog(@"settings found");
    }
    else
    {
        NSLog(@"settings missing..");
    }
    
    NSDictionary *settings=[NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *prefrences=[settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister=[[NSMutableDictionary alloc]initWithCapacity:[prefrences count]];
    
    for(NSDictionary *prefSpecs in prefrences)
    {
        NSString *key=[prefSpecs objectForKey:@"Key"];
        if(key)
        {
            [defaultsToRegister setObject:[prefSpecs objectForKey:@"DefaultValue"] forKey:key];
        }
        else
        {
            NSLog(@"key not found..");
        }
    }
    
    [[NSUserDefaults standardUserDefaults]registerDefaults:defaultsToRegister];
    [defaultsToRegister release];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *urlString=[defaults stringForKey:@"server_url"];
    //NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
    
    NSURL *url=[[messengerAppDelegate sharedAppDelegate]smartURLForString:[NSString stringWithFormat:@"%@/v1/%@",urlString,endPointURL]];
    
    NSLog(@"Sending Request to URL %@", url);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSString *contentType=[NSString stringWithFormat:@"application/XML"];
    [request addValue:contentType forHTTPHeaderField:@"Content-type"];
    
    /*Build the XML structure to send*/
    if([endPointURL isEqualToString:@"add"])
    {
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<user xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserId>%@</UserId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserName>%@</UserName>",userName]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserPassword>%@</UserPassword>",password]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<EmailAddress>%@</EmailAddress>",emailID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</user>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
    }
    else if([endPointURL isEqualToString:@"login"])
    {
        NSLog(@"logging..");
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<user xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserId>%@</UserId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserPassword>%@</UserPassword>",password]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</user>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
    }
    else if ([endPointURL isEqualToString:@"listMemberGroups"])
    {
        NSLog(@"userid received is: %@",userID);
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<user xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserId>%@</UserId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</user>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
    }
        
    
    /*Handle the synchronous response here*/
    NSError			*requestError;
	NSURLResponse	*urlResponse;
	NSError			*error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request
												 returningResponse:&urlResponse
															 error:&requestError];
	if (error == nil)
    {
		if ([urlResponse isKindOfClass:[NSHTTPURLResponse class]])
        {
			NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
			/*If the call was okay, then invoke the parser*/
			if ((status >= 200) && (status < 300))
            {
                NSLog(@"sending parse request with: %@",responseData);
                accessPtr = [[BaseRESTparser alloc]init];
                NSLog(@"parsing for: %@",endPointURL);
                NSString *xml = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                NSLog(@"xml for: %@ = %@",endPointURL,xml);
                [xml release];
				[accessPtr parseDocument:responseData:endPointURL];
                //[self receiveMessage:@"list"];
                retVal=1;
			}
            else
            {
                NSLog(@"status error: %d and %@",status,httpResponse);
                retVal=0;
            }
		}
        else
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) urlResponse;
			int status = [httpResponse statusCode];
            NSLog(@"Unable to complete the request: %@",urlResponse);
            NSLog(@"status error: %d and %@",status,httpResponse);
            retVal=0;
        }
	}
    else
    {
        retVal=0;
    }
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return retVal;
}



-(void)valueToReturn:(int)value
{
    valueToReturn=value;
}

-(int)returnValue
{
    return valueToReturn;
}

/*Received at the start of the asynchronous response from the server.  This may get called multiple times in certain redirect scenerios.*/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{	
	NSLog(@"Received Response");
	NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *) response;;
    
    NSLog(@"response is: %@",response);
    
	if ([response isKindOfClass:[NSHTTPURLResponse class]])
    {
		int status = [httpResponse statusCode];
		
		if (!((status >= 200) && (status < 300)))
        {
			NSLog(@"Connection failed with status %d", status);
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
        else
        {
			/*make the working space for the REST data buffer.This could also be a file if you want to reduce the RAM footprint*/
            NSLog(@"Init RAM footprint..");
			[wipData release];
			wipData = [[NSMutableData alloc] initWithCapacity:1024];
        }
    }
    else
    {
        NSLog(@"response type: %@",httpResponse);
    }
}

/*A delegate method called by the NSURLConnection when something happens with the
 connection security-wise.  We defer all of the logic for how to handle this to
 the ChallengeHandler module (and it's very custom subclasses).
*/
- (BOOL)connection:(NSURLConnection *)conn canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    NSLog(@"handling challenge..");
    
    return TRUE;
}

/*A delegate method called by the NSURLConnection when you accept a specific
authentication challenge by returning YES from connection:canAuthenticateAgainstProtectionSpace:.
Again, most of the logic has been shuffled off to the ChallengeHandler module; the only
policy decision we make here is that, if the challenge handle doesn't get it right in 5 tries,
we bail out.
*/
- (void)connection:(NSURLConnection *)conn didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
#pragma unused(conn)
    assert(challenge != nil);
    
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    assert(currentChallenge == nil);
    if ([challenge previousFailureCount] < 5)
    {
        currentChallenge = [ChallengeHandler handlerForChallenge:challenge parentViewController:self];
        if (currentChallenge == nil)
        {
            NSLog(@"no challenge ");
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
        else
        {
            NSLog(@"taking challenge ");
            currentChallenge.delegate = self;
            [currentChallenge start];
        }
    }
    else
    {
        NSLog(@"cancelling challenge ");
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

/*Can be called multiple times with chunks of the transfer*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"data received: %@",data);
	[wipData appendData:data];
}

/*Called once at the end of the request*/
- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
	/*Do a little debug dump*/
    accessPtr = [[BaseRESTparser alloc]init];
	NSString *xml = [[NSString alloc] initWithData:wipData encoding:NSUTF8StringEncoding];
	NSLog(@"xml = %@", xml);
	[xml release];
	
    NSLog(@"wip data is: %@",wipData);
    
    /*Parse inbound XML response to BaseRESTparser*/
	[accessPtr parseDocument:wipData:serviceEndPoint];
    
	/*turn off the network indicator*/
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

        
/*On the start of every element, clearn the intraelement text*/
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    accessPtr = [[BaseRESTparser alloc]init];
	[accessPtr clearContentsOfElement];
}

/*Called for each element*/
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    accessPtr = [[BaseRESTparser alloc]init];
    [accessPtr clearContentsOfElement];
}

@end
