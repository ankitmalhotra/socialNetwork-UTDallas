#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class s1_categoriestype;
@class s1_categorytype;
@class s1_compositionstype;
@class s1_compositiontype;
@class s1_textauthorstype;
@class s1_notestype;
@class s1_performancenotestype;
@class s1_publicationstype;
@class s1_recordingstype;
@class s1_textauthortype;
@class s1_performancenotetype;
@class s1_publicationtype;
@class s1_minimaldetailstype;
@class s1_recordingtype;
typedef enum {
	s1_categoryidtype_none = 0,
	s1_categoryidtype_All,
	s1_categoryidtype_BA,
	s1_categoryidtype_BB,
	s1_categoryidtype_CC,
	s1_categoryidtype_CH,
	s1_categoryidtype_CM,
	s1_categoryidtype_CO,
	s1_categoryidtype_FM,
	s1_categoryidtype_IN,
	s1_categoryidtype_OG,
	s1_categoryidtype_OP,
	s1_categoryidtype_OR,
	s1_categoryidtype_PA,
	s1_categoryidtype_PN,
	s1_categoryidtype_SS,
	s1_categoryidtype_WS,
} s1_categoryidtype;
s1_categoryidtype s1_categoryidtype_enumFromString(NSString *string);
NSString * s1_categoryidtype_stringFromEnum(s1_categoryidtype enumValue);
@interface s1_categorytype : NSString  {
	
/* elements */
/* attributes */
	s1_categoryidtype id_;
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_categorytype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@property (assign) s1_categoryidtype id_;
@end
@interface s1_categoriestype : NSObject {
	
/* elements */
	NSMutableArray *category;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_categoriestype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addCategory:(s1_categorytype *)toAdd;
@property (readonly) NSMutableArray * category;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_textauthortype : NSString  {
	
/* elements */
/* attributes */
	NSNumber * id_;
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_textauthortype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
/* attributes */
- (NSDictionary *)attributes;
@property (retain) NSNumber * id_;
@end
@interface s1_textauthorstype : NSObject {
	
/* elements */
	NSMutableArray *text-author;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_textauthorstype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addText-author:(s1_textauthortype *)toAdd;
@property (readonly) NSMutableArray * text-author;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_notestype : NSObject {
	
/* elements */
	NSMutableArray *note;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_notestype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addNote:(NSString *)toAdd;
@property (readonly) NSMutableArray * note;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_performancenotetype : NSObject {
	
/* elements */
	NSString * heading;
	NSString * performance;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_performancenotetype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * heading;
@property (retain) NSString * performance;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_performancenotestype : NSObject {
	
/* elements */
	NSMutableArray *performance-note;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_performancenotestype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPerformance-note:(s1_performancenotetype *)toAdd;
@property (readonly) NSMutableArray * performance-note;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_minimaldetailstype : NSObject {
	
/* elements */
	NSString * name;
	NSString * town;
	NSString * country;
	NSString * url;
/* attributes */
	NSNumber * id_;
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_minimaldetailstype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * name;
@property (retain) NSString * town;
@property (retain) NSString * country;
@property (retain) NSString * url;
/* attributes */
- (NSDictionary *)attributes;
@property (retain) NSNumber * id_;
@end
@interface s1_publicationtype : NSObject {
	
/* elements */
	NSString * publication-year;
	s1_minimaldetailstype * publisher;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_publicationtype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * publication-year;
@property (retain) s1_minimaldetailstype * publisher;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_publicationstype : NSObject {
	
/* elements */
	NSMutableArray *publication;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_publicationstype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addPublication:(s1_publicationtype *)toAdd;
@property (readonly) NSMutableArray * publication;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface s1_recordingtype : NSObject {
	
/* elements */
	NSString * title;
	NSString * format;
	NSNumber * year;
	NSString * catalog-no;
	NSString * purchase-url;
	s1_minimaldetailstype * record-company;
/* attributes */
	NSNumber * id_;
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_recordingtype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * title;
@property (retain) NSString * format;
@property (retain) NSNumber * year;
@property (retain) NSString * catalog-no;
@property (retain) NSString * purchase-url;
@property (retain) s1_minimaldetailstype * record-company;
/* attributes */
- (NSDictionary *)attributes;
@property (retain) NSNumber * id_;
@end
@interface s1_recordingstype : NSObject {
	
/* elements */
	NSMutableArray *recording;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_recordingstype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addRecording:(s1_recordingtype *)toAdd;
@property (readonly) NSMutableArray * recording;
/* attributes */
- (NSDictionary *)attributes;
@end
typedef enum {
	s1_yesnotype_none = 0,
	s1_yesnotype_yes,
	s1_yesnotype_no,
} s1_yesnotype;
s1_yesnotype s1_yesnotype_enumFromString(NSString *string);
NSString * s1_yesnotype_stringFromEnum(s1_yesnotype enumValue);
@interface s1_compositiontype : NSObject {
	
/* elements */
	NSString * title;
	NSString * description;
	NSNumber * year;
	NSString * opus;
	NSString * instrumentation;
	NSNumber * duration-minutes;
	s1_textauthorstype * text-authors;
	s1_notestype * notes;
	s1_performancenotestype * performance-notes;
	s1_publicationstype * publications;
	s1_recordingstype * recordings;
/* attributes */
	NSNumber * id_;
	s1_categoryidtype category-id;
	NSString * category;
	s1_yesnotype commentary;
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_compositiontype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * title;
@property (retain) NSString * description;
@property (retain) NSNumber * year;
@property (retain) NSString * opus;
@property (retain) NSString * instrumentation;
@property (retain) NSNumber * duration-minutes;
@property (retain) s1_textauthorstype * text-authors;
@property (retain) s1_notestype * notes;
@property (retain) s1_performancenotestype * performance-notes;
@property (retain) s1_publicationstype * publications;
@property (retain) s1_recordingstype * recordings;
/* attributes */
- (NSDictionary *)attributes;
@property (retain) NSNumber * id_;
@property (assign) s1_categoryidtype category-id;
@property (retain) NSString * category;
@property (assign) s1_yesnotype commentary;
@end
@interface s1_compositionstype : NSObject {
	
/* elements */
	NSMutableArray *composition;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (s1_compositionstype *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addComposition:(s1_compositiontype *)toAdd;
@property (readonly) NSMutableArray * composition;
/* attributes */
- (NSDictionary *)attributes;
@end
