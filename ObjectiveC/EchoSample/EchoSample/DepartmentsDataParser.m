//
//  DepartmentsDataParser.m
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "DepartmentsDataParser.h"
#import "DepartmentsData.h"

@implementation DepartmentsDataParser
-(id)initWithArray: (NSMutableArray *) array{
    self = [super init];
    if (self) {
        self.array = array;
    }
    return self;
}
-(void)parseXMLFile {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"departments" ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
    self.parser = [[NSXMLParser alloc] initWithData:data];
    self.parser.delegate = self;
    [self.parser parse];
}
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    self.element = elementName;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if ([self.element  isEqual: @"Name"]) {
        self.currentName = string;
    }

    else if ([self.element  isEqual: @"Id"]) {
        self.currentDepartmentID = @(string.integerValue);
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"Department"]) {
        DepartmentsData *department = [[DepartmentsData alloc] init];
        department.departmentID = self.currentDepartmentID;
        department.name = self.currentName;
        [self.array addObject:department];
    }
    self.element = nil;
}

@end
