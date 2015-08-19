//
//  FinancialData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinancialData : NSObject

@property NSDate *date;
@property NSNumber *open;
@property NSNumber *high;
@property NSNumber *low;
@property NSNumber *close;
@property NSNumber *volume;

-(id)initWithDate: (NSDate *)date open: (NSNumber *)open high: (NSNumber *)high low: (NSNumber *)low close: (NSNumber *)close volume: (NSNumber *)volume;

+(NSMutableArray *)demoData;
@end
