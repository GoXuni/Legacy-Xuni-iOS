//
//  DynamicChartData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//


#import "DynamicChartData.h"

@implementation DynamicChartData

- (id)initWithNum:(NSString *)time trucks:(NSNumber *)trucks ships:(NSNumber *)ships planes:(NSNumber *)planes{
    self = [super init];
    if(self){
        _time = time;
        _trucks = trucks;
        _ships = ships;
        _planes = planes;
    }
    return self;
}

+ (NSInteger)randomNumberBetween:(NSInteger)min max:(NSInteger)max {
    return min + rand() % (max - min + 1);
}

+ (DynamicChartData *)getOneData {
    NSInteger num = [DynamicChartData randomNumberBetween:0 max:1000];
    
    while (num < 900)
    {
        num = [DynamicChartData randomNumberBetween:0 max:1000];
    }
    
    NSNumber *trucks = [NSNumber numberWithInteger:num + 20];
    NSNumber *ships = [NSNumber numberWithInteger:num + 10];
    NSNumber *planes = [NSNumber numberWithInteger:num];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"mm:ss"];
    NSDate *d = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *time = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:d]];
    
    return [[DynamicChartData alloc] initWithNum:time trucks:trucks ships:ships planes:planes];
}

+ (NSMutableArray *)demoData {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 8; i++) {
        [array addObject:[DynamicChartData getOneData]];
    }
    
    return array;
}

+ (NSMutableArray *)dynamicData:(NSMutableArray *)array {
    if ([array count] > 30) {
        [array removeObjectAtIndex:0];
    }
    
    [array addObject:[DynamicChartData getOneData]];

    return array;
}
@end
