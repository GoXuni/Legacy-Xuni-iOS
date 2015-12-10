//
//  DepartmentsDataParser.h
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepartmentsDataParser : NSObject<NSXMLParserDelegate>

@property NSString *element;
@property NSString *currentName;
@property NSNumber *currentDepartmentID;
@property NSMutableArray *array;
@property NSXMLParser *parser;

-(id)initWithArray: (NSMutableArray *) array;
-(void)parseXMLFile;
@end
