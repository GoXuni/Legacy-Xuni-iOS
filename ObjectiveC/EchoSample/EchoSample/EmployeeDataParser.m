//
//  EmployeeDataParser.m
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "EmployeeDataParser.h"
#import "EmployeeData.h"
@implementation EmployeeDataParser
-(id)initWithArray: (NSMutableArray *) array{
    self = [super init];
    if (self) {
        self.array = array;
    }
    return self;
}
-(void)parseXMLFile {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"employees" ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
    //NSURL *filepath = [[NSBundle mainBundle] URLForResource:@"employees" withExtension:@"xml"];
    [self setDateFormat];
    self.parser = [[NSXMLParser alloc] initWithData:data];
    self.parser.delegate = self;
    [self.parser parse];
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    self.element = elementName;
}

-(void)setDateFormat {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([self.element  isEqual: @"Name"]) {
        self.currentName = string;
    }
    else if ([self.element  isEqual: @"Title"]) {
        self.currentTitle = string;
    }
    else if ([self.element  isEqual: @"DepartmentId"]) {
        self.currentDepartmentID = @(string.integerValue);
    }
    else if ([self.element  isEqual: @"HireDate"]) {
        self.currentHireDate = [self.dateFormatter dateFromString:string];
    }
    else if ([self.element  isEqual: @"Status"]) {
        self.currentStatus = string.doubleValue;
    }
    else if ([self.element  isEqual: @"FullTime"]) {
        self.currentFulltime = [string  isEqual: @"true"]?true:false ;
    }
    else if ([self.element  isEqual: @"ThumbnailImage"]) {
        self.currentThumbnailImage = string;
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"Employee"]) {
        EmployeeData *employee = [[EmployeeData alloc] init];
        employee.name = self.currentName;
        employee.title = self.currentTitle;
        employee.departmentID = self.currentDepartmentID;
        employee.hireDate = self.currentHireDate;
        employee.status = self.currentStatus;
        employee.fulltime = self.currentFulltime;
        employee.thumbnailImage = self.currentThumbnailImage;
        [self.array addObject:employee];
    }
    self.element = nil;
}
@end
