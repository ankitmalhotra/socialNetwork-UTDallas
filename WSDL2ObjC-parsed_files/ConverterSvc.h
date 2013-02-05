#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ConverterSvc_celsiusToFarenheit;
@class ConverterSvc_celsiusToFarenheitResponse;
@class ConverterSvc_farenheitToCelsius;
@class ConverterSvc_farenheitToCelsiusResponse;
@interface ConverterSvc_celsiusToFarenheit : NSObject {
	
/* elements */
	NSNumber * celsius;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ConverterSvc_celsiusToFarenheit *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * celsius;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ConverterSvc_celsiusToFarenheitResponse : NSObject {
	
/* elements */
	NSNumber * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ConverterSvc_celsiusToFarenheitResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ConverterSvc_farenheitToCelsius : NSObject {
	
/* elements */
	NSNumber * farenheit;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ConverterSvc_farenheitToCelsius *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * farenheit;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ConverterSvc_farenheitToCelsiusResponse : NSObject {
	
/* elements */
	NSNumber * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ConverterSvc_farenheitToCelsiusResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSNumber * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "ConverterSvc.h"
@class ConverterSoap11Binding;
@class ConverterSoap12Binding;
@interface ConverterSvc : NSObject {
	
}
+ (ConverterSoap11Binding *)ConverterSoap11Binding;
+ (ConverterSoap12Binding *)ConverterSoap12Binding;
@end
@class ConverterSoap11BindingResponse;
@class ConverterSoap11BindingOperation;
@protocol ConverterSoap11BindingResponseDelegate <NSObject>
- (void) operation:(ConverterSoap11BindingOperation *)operation completedWithResponse:(ConverterSoap11BindingResponse *)response;
@end
@interface ConverterSoap11Binding : NSObject <ConverterSoap11BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ConverterSoap11BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ConverterSoap11BindingResponse *)celsiusToFarenheitUsingParameters:(ConverterSvc_celsiusToFarenheit *)aParameters ;
- (void)celsiusToFarenheitAsyncUsingParameters:(ConverterSvc_celsiusToFarenheit *)aParameters  delegate:(id<ConverterSoap11BindingResponseDelegate>)responseDelegate;
- (ConverterSoap11BindingResponse *)farenheitToCelsiusUsingParameters:(ConverterSvc_farenheitToCelsius *)aParameters ;
- (void)farenheitToCelsiusAsyncUsingParameters:(ConverterSvc_farenheitToCelsius *)aParameters  delegate:(id<ConverterSoap11BindingResponseDelegate>)responseDelegate;
@end
@interface ConverterSoap11BindingOperation : NSOperation {
	ConverterSoap11Binding *binding;
	ConverterSoap11BindingResponse *response;
	id<ConverterSoap11BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ConverterSoap11Binding *binding;
@property (readonly) ConverterSoap11BindingResponse *response;
@property (nonatomic, assign) id<ConverterSoap11BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ConverterSoap11Binding *)aBinding delegate:(id<ConverterSoap11BindingResponseDelegate>)aDelegate;
@end
@interface ConverterSoap11Binding_celsiusToFarenheit : ConverterSoap11BindingOperation {
	ConverterSvc_celsiusToFarenheit * parameters;
}
@property (retain) ConverterSvc_celsiusToFarenheit * parameters;
- (id)initWithBinding:(ConverterSoap11Binding *)aBinding delegate:(id<ConverterSoap11BindingResponseDelegate>)aDelegate
	parameters:(ConverterSvc_celsiusToFarenheit *)aParameters
;
@end
@interface ConverterSoap11Binding_farenheitToCelsius : ConverterSoap11BindingOperation {
	ConverterSvc_farenheitToCelsius * parameters;
}
@property (retain) ConverterSvc_farenheitToCelsius * parameters;
- (id)initWithBinding:(ConverterSoap11Binding *)aBinding delegate:(id<ConverterSoap11BindingResponseDelegate>)aDelegate
	parameters:(ConverterSvc_farenheitToCelsius *)aParameters
;
@end
@interface ConverterSoap11Binding_envelope : NSObject {
}
+ (ConverterSoap11Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ConverterSoap11BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class ConverterSoap12BindingResponse;
@class ConverterSoap12BindingOperation;
@protocol ConverterSoap12BindingResponseDelegate <NSObject>
- (void) operation:(ConverterSoap12BindingOperation *)operation completedWithResponse:(ConverterSoap12BindingResponse *)response;
@end
@interface ConverterSoap12Binding : NSObject <ConverterSoap12BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(ConverterSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (ConverterSoap12BindingResponse *)celsiusToFarenheitUsingParameters:(ConverterSvc_celsiusToFarenheit *)aParameters ;
- (void)celsiusToFarenheitAsyncUsingParameters:(ConverterSvc_celsiusToFarenheit *)aParameters  delegate:(id<ConverterSoap12BindingResponseDelegate>)responseDelegate;
- (ConverterSoap12BindingResponse *)farenheitToCelsiusUsingParameters:(ConverterSvc_farenheitToCelsius *)aParameters ;
- (void)farenheitToCelsiusAsyncUsingParameters:(ConverterSvc_farenheitToCelsius *)aParameters  delegate:(id<ConverterSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface ConverterSoap12BindingOperation : NSOperation {
	ConverterSoap12Binding *binding;
	ConverterSoap12BindingResponse *response;
	id<ConverterSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) ConverterSoap12Binding *binding;
@property (readonly) ConverterSoap12BindingResponse *response;
@property (nonatomic, assign) id<ConverterSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(ConverterSoap12Binding *)aBinding delegate:(id<ConverterSoap12BindingResponseDelegate>)aDelegate;
@end
@interface ConverterSoap12Binding_celsiusToFarenheit : ConverterSoap12BindingOperation {
	ConverterSvc_celsiusToFarenheit * parameters;
}
@property (retain) ConverterSvc_celsiusToFarenheit * parameters;
- (id)initWithBinding:(ConverterSoap12Binding *)aBinding delegate:(id<ConverterSoap12BindingResponseDelegate>)aDelegate
	parameters:(ConverterSvc_celsiusToFarenheit *)aParameters
;
@end
@interface ConverterSoap12Binding_farenheitToCelsius : ConverterSoap12BindingOperation {
	ConverterSvc_farenheitToCelsius * parameters;
}
@property (retain) ConverterSvc_farenheitToCelsius * parameters;
- (id)initWithBinding:(ConverterSoap12Binding *)aBinding delegate:(id<ConverterSoap12BindingResponseDelegate>)aDelegate
	parameters:(ConverterSvc_farenheitToCelsius *)aParameters
;
@end
@interface ConverterSoap12Binding_envelope : NSObject {
}
+ (ConverterSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface ConverterSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
