#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class GroupsDataServiceServiceSvc_GetGroupsData;
@class GroupsDataServiceServiceSvc_GetGroupsDataResponse;
@class GroupsDataServiceServiceSvc_CreateUserGroup;
@class GroupsDataServiceServiceSvc_CreateUserGroupResponse;
#import "ax22.h"
@interface GroupsDataServiceServiceSvc_GetGroupsData : NSObject {
	
/* elements */
	NSString * UserId;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GroupsDataServiceServiceSvc_GetGroupsData *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * UserId;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GroupsDataServiceServiceSvc_GetGroupsDataResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GroupsDataServiceServiceSvc_GetGroupsDataResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GroupsDataServiceServiceSvc_CreateUserGroup : NSObject {
	
/* elements */
	ax22_UserDetails * userDetailsobject;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GroupsDataServiceServiceSvc_CreateUserGroup *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) ax22_UserDetails * userDetailsobject;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface GroupsDataServiceServiceSvc_CreateUserGroupResponse : NSObject {
	
/* elements */
	NSString * return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GroupsDataServiceServiceSvc_CreateUserGroupResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "GroupsDataServiceServiceSvc.h"
#import "ax22.h"
@class GroupsDataServiceServiceSoap11Binding;
@class GroupsDataServiceServiceSoap12Binding;
@interface GroupsDataServiceServiceSvc : NSObject {
	
}
+ (GroupsDataServiceServiceSoap11Binding *)GroupsDataServiceServiceSoap11Binding;
+ (GroupsDataServiceServiceSoap12Binding *)GroupsDataServiceServiceSoap12Binding;
@end
@class GroupsDataServiceServiceSoap11BindingResponse;
@class GroupsDataServiceServiceSoap11BindingOperation;
@protocol GroupsDataServiceServiceSoap11BindingResponseDelegate <NSObject>
- (void) operation:(GroupsDataServiceServiceSoap11BindingOperation *)operation completedWithResponse:(GroupsDataServiceServiceSoap11BindingResponse *)response;
@end
@interface GroupsDataServiceServiceSoap11Binding : NSObject <GroupsDataServiceServiceSoap11BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(GroupsDataServiceServiceSoap11BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (GroupsDataServiceServiceSoap11BindingResponse *)GetGroupsDataUsingParameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters ;
- (void)GetGroupsDataAsyncUsingParameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters  delegate:(id<GroupsDataServiceServiceSoap11BindingResponseDelegate>)responseDelegate;
- (GroupsDataServiceServiceSoap11BindingResponse *)CreateUserGroupUsingParameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters ;
- (void)CreateUserGroupAsyncUsingParameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters  delegate:(id<GroupsDataServiceServiceSoap11BindingResponseDelegate>)responseDelegate;
@end
@interface GroupsDataServiceServiceSoap11BindingOperation : NSOperation {
	GroupsDataServiceServiceSoap11Binding *binding;
	GroupsDataServiceServiceSoap11BindingResponse *response;
	id<GroupsDataServiceServiceSoap11BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) GroupsDataServiceServiceSoap11Binding *binding;
@property (readonly) GroupsDataServiceServiceSoap11BindingResponse *response;
@property (nonatomic, assign) id<GroupsDataServiceServiceSoap11BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(GroupsDataServiceServiceSoap11Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap11BindingResponseDelegate>)aDelegate;
@end
@interface GroupsDataServiceServiceSoap11Binding_GetGroupsData : GroupsDataServiceServiceSoap11BindingOperation {
	GroupsDataServiceServiceSvc_GetGroupsData * parameters;
}
@property (retain) GroupsDataServiceServiceSvc_GetGroupsData * parameters;
- (id)initWithBinding:(GroupsDataServiceServiceSoap11Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap11BindingResponseDelegate>)aDelegate
	parameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters
;
@end
@interface GroupsDataServiceServiceSoap11Binding_CreateUserGroup : GroupsDataServiceServiceSoap11BindingOperation {
	GroupsDataServiceServiceSvc_CreateUserGroup * parameters;
}
@property (retain) GroupsDataServiceServiceSvc_CreateUserGroup * parameters;
- (id)initWithBinding:(GroupsDataServiceServiceSoap11Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap11BindingResponseDelegate>)aDelegate
	parameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters
;
@end
@interface GroupsDataServiceServiceSoap11Binding_envelope : NSObject {
}
+ (GroupsDataServiceServiceSoap11Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface GroupsDataServiceServiceSoap11BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class GroupsDataServiceServiceSoap12BindingResponse;
@class GroupsDataServiceServiceSoap12BindingOperation;
@protocol GroupsDataServiceServiceSoap12BindingResponseDelegate <NSObject>
- (void) operation:(GroupsDataServiceServiceSoap12BindingOperation *)operation completedWithResponse:(GroupsDataServiceServiceSoap12BindingResponse *)response;
@end
@interface GroupsDataServiceServiceSoap12Binding : NSObject <GroupsDataServiceServiceSoap12BindingResponseDelegate> {
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
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(GroupsDataServiceServiceSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (GroupsDataServiceServiceSoap12BindingResponse *)GetGroupsDataUsingParameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters ;
- (void)GetGroupsDataAsyncUsingParameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters  delegate:(id<GroupsDataServiceServiceSoap12BindingResponseDelegate>)responseDelegate;
- (GroupsDataServiceServiceSoap12BindingResponse *)CreateUserGroupUsingParameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters ;
- (void)CreateUserGroupAsyncUsingParameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters  delegate:(id<GroupsDataServiceServiceSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface GroupsDataServiceServiceSoap12BindingOperation : NSOperation {
	GroupsDataServiceServiceSoap12Binding *binding;
	GroupsDataServiceServiceSoap12BindingResponse *response;
	id<GroupsDataServiceServiceSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) GroupsDataServiceServiceSoap12Binding *binding;
@property (readonly) GroupsDataServiceServiceSoap12BindingResponse *response;
@property (nonatomic, assign) id<GroupsDataServiceServiceSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(GroupsDataServiceServiceSoap12Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap12BindingResponseDelegate>)aDelegate;
@end
@interface GroupsDataServiceServiceSoap12Binding_GetGroupsData : GroupsDataServiceServiceSoap12BindingOperation {
	GroupsDataServiceServiceSvc_GetGroupsData * parameters;
}
@property (retain) GroupsDataServiceServiceSvc_GetGroupsData * parameters;
- (id)initWithBinding:(GroupsDataServiceServiceSoap12Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(GroupsDataServiceServiceSvc_GetGroupsData *)aParameters
;
@end
@interface GroupsDataServiceServiceSoap12Binding_CreateUserGroup : GroupsDataServiceServiceSoap12BindingOperation {
	GroupsDataServiceServiceSvc_CreateUserGroup * parameters;
}
@property (retain) GroupsDataServiceServiceSvc_CreateUserGroup * parameters;
- (id)initWithBinding:(GroupsDataServiceServiceSoap12Binding *)aBinding delegate:(id<GroupsDataServiceServiceSoap12BindingResponseDelegate>)aDelegate
	parameters:(GroupsDataServiceServiceSvc_CreateUserGroup *)aParameters
;
@end
@interface GroupsDataServiceServiceSoap12Binding_envelope : NSObject {
}
+ (GroupsDataServiceServiceSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface GroupsDataServiceServiceSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
