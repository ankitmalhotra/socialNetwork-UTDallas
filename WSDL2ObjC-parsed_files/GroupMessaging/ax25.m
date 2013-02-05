#import "ax25.h"
#import <libxml/xmlstring.h>
#if TARGET_OS_IPHONE
#import <CFNetwork/CFNetwork.h>
#endif
@implementation GroupsDataServiceServiceSvc_Exception
- (id)init
{
	if((self = [super init])) {
		Exception = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(Exception != nil) [Exception release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"GroupsDataServiceServiceSvc";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", @"GroupsDataServiceServiceSvc", elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	
	if(self.Exception != 0) {
		xmlAddChild(node, [self.Exception xmlNodeForDoc:node->doc elementName:@"Exception" elementNSPrefix:@"GroupsDataServiceServiceSvc"]);
	}
}
/* elements */
@synthesize Exception;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (GroupsDataServiceServiceSvc_Exception *)deserializeNode:(xmlNodePtr)cur
{
	GroupsDataServiceServiceSvc_Exception *newObject = [[GroupsDataServiceServiceSvc_Exception new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "Exception")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.Exception = newChild;
			}
		}
	}
}
@end
@implementation ax25_SQLException
- (id)init
{
	if((self = [super init])) {
		SQLState = 0;
		errorCode = 0;
		nextException = 0;
	}
	
	return self;
}
- (void)dealloc
{
	if(SQLState != nil) [SQLState release];
	if(errorCode != nil) [errorCode release];
	if(nextException != nil) [nextException release];
	
	[super dealloc];
}
- (NSString *)nsPrefix
{
	return @"ax25";
}
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix
{
	NSString *nodeName = nil;
	if(elNSPrefix != nil && [elNSPrefix length] > 0)
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", elNSPrefix, elName];
	}
	else
	{
		nodeName = [NSString stringWithFormat:@"%@:%@", @"ax25", elName];
	}
	
	xmlNodePtr node = xmlNewDocNode(doc, NULL, [nodeName xmlString], NULL);
	
	xmlNodePtr root = xmlDocGetRootElement(doc);
	xmlNsPtr xsi = xmlSearchNs(doc, root, (const xmlChar*)"xsi");
	xmlSetNsProp(node, xsi, (const xmlChar*)"type", (const xmlChar*)"ax25:SQLException");
	
	[self addAttributesToNode:node];
	
	[self addElementsToNode:node];
	
	return node;
}
- (void)addAttributesToNode:(xmlNodePtr)node
{
	[super addAttributesToNode:node];
	
}
- (void)addElementsToNode:(xmlNodePtr)node
{
	[super addElementsToNode:node];
	
	if(self.SQLState != 0) {
		xmlAddChild(node, [self.SQLState xmlNodeForDoc:node->doc elementName:@"SQLState" elementNSPrefix:@"ax25"]);
	}
	if(self.errorCode != 0) {
		xmlAddChild(node, [self.errorCode xmlNodeForDoc:node->doc elementName:@"errorCode" elementNSPrefix:@"ax25"]);
	}
	if(self.nextException != 0) {
		xmlAddChild(node, [self.nextException xmlNodeForDoc:node->doc elementName:@"nextException" elementNSPrefix:@"ax25"]);
	}
}
/* elements */
@synthesize SQLState;
@synthesize errorCode;
@synthesize nextException;
/* attributes */
- (NSDictionary *)attributes
{
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	
	return attributes;
}
+ (ax25_SQLException *)deserializeNode:(xmlNodePtr)cur
{
	ax25_SQLException *newObject = [[ax25_SQLException new] autorelease];
	
	[newObject deserializeAttributesFromNode:cur];
	[newObject deserializeElementsFromNode:cur];
	
	return newObject;
}
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur
{
	[super deserializeAttributesFromNode:cur];
}
- (void)deserializeElementsFromNode:(xmlNodePtr)cur
{
	
	[super deserializeElementsFromNode:cur];
	
	for( cur = cur->children ; cur != NULL ; cur = cur->next ) {
		if(cur->type == XML_ELEMENT_NODE) {
			xmlChar *elementText = xmlNodeListGetString(cur->doc, cur->children, 1);
			NSString *elementString = nil;
			
			if(elementText != NULL) {
				elementString = [NSString stringWithCString:(char*)elementText encoding:NSUTF8StringEncoding];
				[elementString self]; // avoid compiler warning for unused var
				xmlFree(elementText);
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "SQLState")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSString  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.SQLState = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "errorCode")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [NSNumber  class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.errorCode = newChild;
			}
			if(xmlStrEqual(cur->name, (const xmlChar *) "nextException")) {
				
				Class elementClass = nil;
				xmlChar *instanceType = xmlGetNsProp(cur, (const xmlChar *) "type", (const xmlChar *) "http://www.w3.org/2001/XMLSchema-instance");
				if(instanceType == NULL) {
					elementClass = [ax25_SQLException class];
				} else {
					NSString *elementTypeString = [NSString stringWithCString:(char*)instanceType encoding:NSUTF8StringEncoding];
					
					NSArray *elementTypeArray = [elementTypeString componentsSeparatedByString:@":"];
					
					NSString *elementClassString = nil;
					if([elementTypeArray count] > 1) {
						NSString *prefix = [elementTypeArray objectAtIndex:0];
						NSString *localName = [elementTypeArray objectAtIndex:1];
						
						xmlNsPtr elementNamespace = xmlSearchNs(cur->doc, cur, [prefix xmlString]);
						
						NSString *standardPrefix = [[USGlobals sharedInstance].wsdlStandardNamespaces objectForKey:[NSString stringWithCString:(char*)elementNamespace->href encoding:NSUTF8StringEncoding]];
						
						elementClassString = [NSString stringWithFormat:@"%@_%@", standardPrefix, localName];
					} else {
						elementClassString = [elementTypeString stringByReplacingOccurrencesOfString:@":" withString:@"_" options:0 range:NSMakeRange(0, [elementTypeString length])];
					}
					
					elementClass = NSClassFromString(elementClassString);
					xmlFree(instanceType);
				}
				
				id newChild = [elementClass deserializeNode:cur];
				
				self.nextException = newChild;
			}
		}
	}
}
@end
