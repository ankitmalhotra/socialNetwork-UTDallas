#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class AlanBushCompositionsSvc_GetCategories;
@class AlanBushCompositionsSvc_GetCategoriesResponse;
@class AlanBushCompositionsSvc_GetCompositions;
@class AlanBushCompositionsSvc_GetCompositionsResponse;
#import "s1.h"
@interface AlanBushCompositionsSvc_GetCategories : NSObject {
	
/* elements */
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (AlanBushCompositionsSvc_GetCategories *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@end
@interface AlanBushCompositionsSvc_GetCategoriesResponse : NSObject {
	
/* elements */
	s1_categoriestype * categories;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (AlanBushCompositionsSvc_GetCategoriesResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) s1_categoriestype * categories;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface AlanBushCompositionsSvc_GetCompositions : NSObject {
	
/* elements */
	NSString * category-id;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (AlanBushCompositionsSvc_GetCompositions *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * category-id;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface AlanBushCompositionsSvc_GetCompositionsResponse : NSObject {
	
/* elements */
	s1_compositionstype * compositions;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (AlanBushCompositionsSvc_GetCompositionsResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) s1_compositionstype * compositions;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "AlanBushCompositionsSvc.h"
#import "s1.h"
@class AlanBushCompositionsSoapBinding;
@interface AlanBushCompositionsSvc : NSObject {
	
}
+ (AlanBushCompositionsSoapBinding *)AlanBushCompositionsSoapBinding;
@end
@class AlanBushCompositionsSoapBindingResponse;
@class AlanBushCompositionsSoapBindingOperation;
@protocol AlanBushCompositionsSoapBindingResponseDelegate <NSObject>
- (void) operation:(AlanBushCompositionsSoapBindingOperation *)operation completedWithResponse:(AlanBushCompositionsSoapBindingResponse *)response;
@end
@interface AlanBushCompositionsSoapBinding : NSObject <AlanBushCompositionsSoapBindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(AlanBushCompositionsSoapBindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (AlanBushCompositionsSoapBindingResponse *)GetCategoriesUsingParameters:(AlanBushCompositionsSvc_GetCategories *)aParameters ;
- (void)GetCategoriesAsyncUsingParameters:(AlanBushCompositionsSvc_GetCategories *)aParameters  delegate:(id<AlanBushCompositionsSoapBindingResponseDelegate>)responseDelegate;
- (AlanBushCompositionsSoapBindingResponse *)GetCompositionsUsingParameters:(AlanBushCompositionsSvc_GetCompositions *)aParameters ;
- (void)GetCompositionsAsyncUsingParameters:(AlanBushCompositionsSvc_GetCompositions *)aParameters  delegate:(id<AlanBushCompositionsSoapBindingResponseDelegate>)responseDelegate;
@end
@interface AlanBushCompositionsSoapBindingOperation : NSOperation {
	AlanBushCompositionsSoapBinding *binding;
	AlanBushCompositionsSoapBindingResponse *response;
	id<AlanBushCompositionsSoapBindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) AlanBushCompositionsSoapBinding *binding;
@property (readonly) AlanBushCompositionsSoapBindingResponse *response;
@property (nonatomic, assign) id<AlanBushCompositionsSoapBindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(AlanBushCompositionsSoapBinding *)aBinding delegate:(id<AlanBushCompositionsSoapBindingResponseDelegate>)aDelegate;
@end
@interface AlanBushCompositionsSoapBinding_GetCategories : AlanBushCompositionsSoapBindingOperation {
	AlanBushCompositionsSvc_GetCategories * parameters;
}
@property (retain) AlanBushCompositionsSvc_GetCategories * parameters;
- (id)initWithBinding:(AlanBushCompositionsSoapBinding *)aBinding delegate:(id<AlanBushCompositionsSoapBindingResponseDelegate>)aDelegate
	parameters:(AlanBushCompositionsSvc_GetCategories *)aParameters
;
@end
@interface AlanBushCompositionsSoapBinding_GetCompositions : AlanBushCompositionsSoapBindingOperation {
	AlanBushCompositionsSvc_GetCompositions * parameters;
}
@property (retain) AlanBushCompositionsSvc_GetCompositions * parameters;
- (id)initWithBinding:(AlanBushCompositionsSoapBinding *)aBinding delegate:(id<AlanBushCompositionsSoapBindingResponseDelegate>)aDelegate
	parameters:(AlanBushCompositionsSvc_GetCompositions *)aParameters
;
@end
@interface AlanBushCompositionsSoapBinding_envelope : NSObject {
}
+ (AlanBushCompositionsSoapBinding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface AlanBushCompositionsSoapBindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
