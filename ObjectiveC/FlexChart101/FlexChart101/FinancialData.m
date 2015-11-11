//
//  FinancialData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FinancialData.h"

@implementation FinancialData
- (id)initWithDate: (NSDate *)date open: (NSNumber *)open high: (NSNumber *)high low: (NSNumber *)low close: (NSNumber *)close volume: (NSNumber *)volume {
    self = [super init];
    if(self){
        _date = date;
        _open = open;
        _high = high;
        _low = low;
        _close = close;
        _volume = volume;
    }
    return self;
}
+ (NSNumber *) generateRandom: (NSInteger) max {
    return [NSNumber numberWithUnsignedInteger:(arc4random() % max)];
}

+ (NSMutableArray *) demoData {
    NSDate *date = [NSDate date];
    NSDate *previousDate;
    NSNumber *open = [[NSNumber alloc] init];
    NSNumber *high = [[NSNumber alloc] init];
    NSNumber *low = [[NSNumber alloc] init];
    NSNumber *close = [[NSNumber alloc] init];
    NSNumber *volume = [[NSNumber alloc] init];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    FinancialData *yesterday;
    for (int i = 0; i < 25; i++) {
        if(i > 0){
            yesterday = (FinancialData*)[array objectAtIndex:(i - 1)];
            open = yesterday.close;
        }
        else{
            open = @1000.0;
        }
        dateComps.day = i;
        previousDate = [calendar dateByAddingComponents:dateComps toDate:date options:false];
        high = @([open integerValue] + [[FinancialData generateRandom:21] integerValue]);
        low = @([open integerValue] - [[FinancialData generateRandom:21] integerValue]);
        
        NSInteger temp = [high integerValue] == [low integerValue] ? 1 : [high integerValue] - [low integerValue];
        close = @([low integerValue] + [[FinancialData generateRandom:temp] integerValue]);
        volume = [FinancialData generateRandom:101];
        FinancialData *finance = [[FinancialData alloc]initWithDate:previousDate open:open high:high low:low close:close volume:volume];
        [array addObject:finance];
    }
    return array;
}
@end
