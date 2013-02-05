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

/*Using this function for handling synchronous POST calls*/
-(int)sendMessage:(NSString *)userID:(NSString *)userName:(NSString *)password:(NSString *)emailID:(NSString *)endPointURL
{
    NSLog(@"sendMessage in..");
    
    int retVal;
    //int dataHash = (int)data;
    //dataHash=dataHash%17;
    //NSLog(@"userid: %d",dataHash);

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
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/v2/%@",urlString,endPointURL]];
    NSLog(@"Sending Request to URL %@", url);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    NSString *contentType=[NSString stringWithFormat:@"application/XML"];
    [request addValue:contentType forHTTPHeaderField:@"Content-type"];
    
    /*Build the XML structure to send*/
    if(endPointURL==@"add")
    {
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<user xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserId>%f</UserId>",userID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserName>%@</UserName>",userName]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserPassword>%@</UserPassword>",password]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<EmailAddress>%@</EmailAddress>",emailID]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"</user>"]dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postData];
    }
    else if(endPointURL==@"login")
    {
        NSMutableData *postData=[NSMutableData data];
        [postData appendData:[[NSString stringWithFormat:@"<user xmlns=\"http://appserver.utdallas.edu/schema\">"]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserName>%@</UserName>",userName]dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[NSString stringWithFormat:@"<UserPassword>%@</UserPassword>",password]dataUsingEncoding:NSUTF8StringEncoding]];
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
				[accessPtr parseDocument:responseData:endPointURL];
                //[self receiveMessage:@"list"];
                retVal=1;
			}
            else
            {
                NSLog(@"status error: %d",status);
            }
		}
        else
        {
            NSLog(@"Unable to complete the request: %@",urlResponse);
            retVal=0;
        }
	}
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return retVal;
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
			[wipData release];
			wipData = [[NSMutableData alloc] initWithCapacity:1024];
        }
    }
    else
    {
        NSLog(@"response type: %@",httpResponse);
    }
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    NSLog(@"authenticate challenge..");
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"challenge accepted");
    NSArray *trustedHosts = [NSArray arrayWithObjects:@"mytrustedhost",nil];
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
        {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

/*Can be called multiple times with chunks of the transfer*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
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
	//[accessPtr clearContentsOfElement];
}

/*Called for each element*/
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //[accessPtr clearContentsOfElement];
}

@end
