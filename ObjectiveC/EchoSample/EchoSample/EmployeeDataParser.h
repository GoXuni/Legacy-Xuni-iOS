//
//  EmployeeDataParser.h
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeDataParser : NSObject<NSXMLParserDelegate>
@property NSString *element;
@property NSDateFormatter *dateFormatter;
@property double currentStatus;
@property NSDate *currentHireDate;
@property NSString *currentName, *currentTitle, *currentThumbnailImage;
@property BOOL currentFulltime;
@property NSNumber *currentDepartmentID;
@property NSMutableArray *array;
@property NSXMLParser *parser;
-(id)initWithArray: (NSMutableArray *) array;
-(void)parseXMLFile;
@end

