#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ax25_SQLException;
#import "GroupsDataServiceServiceSvc.h"
@interface GroupsDataServiceServiceSvc_Exception : NSObject {
	
/* elements */
	NSString * Exception;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (GroupsDataServiceServiceSvc_Exception *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * Exception;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ax25_SQLException : GroupsDataServiceServiceSvc_Exception {
	
/* elements */
	NSString * SQLState;
	NSNumber * errorCode;
	ax25_SQLException * nextException;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ax25_SQLException *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * SQLState;
@property (retain) NSNumber * errorCode;
@property (retain) ax25_SQLException * nextException;
/* attributes */
- (NSDictionary *)attributes;
@end
