//
//  PieChartData.h
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieChartData : NSObject

@property NSString *name;
@property NSNumber *value;

-(id)initWithName: (NSString *)name value: (NSNumber *)value;

+(NSMutableArray *)demoData;

@end
