//
//  ChartData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChartData : NSObject

@property NSString *name;
@property NSNumber *sales;
@property NSNumber *expenses;
@property NSNumber *downloads;

-(id)initWithName: (NSString *)name sales: (NSNumber *)sales expenses: (NSNumber *)expenses downloads: (NSNumber *)downloads;

+(NSMutableArray *)demoData;

@end