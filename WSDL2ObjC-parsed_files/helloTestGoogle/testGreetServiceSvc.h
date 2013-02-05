#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class testGreetServiceSvc_sayGoodbye;
@class testGreetServiceSvc_sayGoodbyeResponse;
@class testGreetServiceSvc_sayHello;
@class testGreetServiceSvc_sayHelloResponse;
@interface testGreetServiceSvc_sayGoodbye : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (testGreetServiceSvc_sayGoodbye *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface testGreetServiceSvc_sayGoodbyeResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (testGreetServiceSvc_sayGoodbyeResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface testGreetServiceSvc_sayHello : NSObject {
	
/* elements */
	NSString * arg0;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (testGreetServiceSvc_sayHello *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * arg0;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface testGreetServiceSvc_sayHelloResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (testGreetServiceSvc_sayHelloResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xs.h"
#import "testGreetServiceSvc.h"
@class testGreetPortBinding;
@interface testGreetServiceSvc : NSObject {
	
}
+ (testGreetPortBinding *)testGreetPortBinding;
@end
@class testGreetPortBindingResponse;
@class testGreetPortBindingOperation;
@protocol testGreetPortBindingResponseDelegate <NSObject>
- (void) operation:(testGreetPortBindingOperation *)operation completedWithResponse:(testGreetPortBindingResponse *)response;
@end
@interface testGreetPortBinding : NSObject <testGreetPortBindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(testGreetPortBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (testGreetPortBindingResponse *)sayHelloUsingParameters:(testGreetServiceSvc_sayHello *)aParameters ;
- (void)sayHelloAsyncUsingParameters:(testGreetServiceSvc_sayHello *)aParameters  delegate:(id<testGreetPortBindingResponseDelegate>)responseDelegate;
- (testGreetPortBindingResponse *)sayGoodbyeUsingParameters:(testGreetServiceSvc_sayGoodbye *)aParameters ;
- (void)sayGoodbyeAsyncUsingParameters:(testGreetServiceSvc_sayGoodbye *)aParameters  delegate:(id<testGreetPortBindingResponseDelegate>)responseDelegate;
@end
@interface testGreetPortBindingOperation : NSOperation {
	testGreetPortBinding *binding;
	testGreetPortBindingResponse *response;
	id<testGreetPortBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) testGreetPortBinding *binding;
@property (readonly) testGreetPortBindingResponse *response;
@property (nonatomic, assign) id<testGreetPortBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(testGreetPortBinding *)aBinding delegate:(id<testGreetPortBindingResponseDelegate>)aDelegate;
@end
@interface testGreetPortBinding_sayHello : testGreetPortBindingOperation {
	testGreetServiceSvc_sayHello * parameters;
}
@property (retain) testGreetServiceSvc_sayHello * parameters;
- (id)initWithBinding:(testGreetPortBinding *)aBinding delegate:(id<testGreetPortBindingResponseDelegate>)aDelegate
	parameters:(testGreetServiceSvc_sayHello *)aParameters
;
@end
@interface testGreetPortBinding_sayGoodbye : testGreetPortBindingOperation {
	testGreetServiceSvc_sayGoodbye * parameters;
}
@property (retain) testGreetServiceSvc_sayGoodbye * parameters;
- (id)initWithBinding:(testGreetPortBinding *)aBinding delegate:(id<testGreetPortBindingResponseDelegate>)aDelegate
	parameters:(testGreetServiceSvc_sayGoodbye *)aParameters
;
@end
@interface testGreetPortBinding_envelope : NSObject {
}
+ (testGreetPortBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface testGreetPortBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
