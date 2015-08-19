//
//  DynamicChartData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//


#import "DynamicChartData.h"

@implementation DynamicChartData



-(id)initWithNum:(NSNumber *)time trucks:(NSNumber *)trucks ships:(NSNumber *)ships planes:(NSNumber *)planes{
    self = [super init];
    if(self){
        _time = time;
        _trucks = trucks;
        _ships = ships;
        _planes = planes;
    }
    return self;
}

+(NSNumber *) generateRandom: (unsigned int) max{
    return [NSNumber numberWithUnsignedInteger:(arc4random()% max)];
}

+(NSMutableArray *) demoData{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        DynamicChartData *dynamic = [[DynamicChartData alloc]initWithNum:@(i) trucks:@(920.0 + [[DynamicChartData generateRandom:(101)] integerValue]) ships: @(910.0 + [[DynamicChartData generateRandom:(101)] integerValue]) planes:@(900.0 + [[DynamicChartData generateRandom:(101)] integerValue])];
        [array addObject:dynamic];
    }
    return array;
}
+(NSMutableArray *) dynamicData: (NSMutableArray *) array{
    if ([array count] > 8) {
        [array removeObjectAtIndex:0];
    }
    DynamicChartData *d = (DynamicChartData *)[array objectAtIndex:7];
    
    DynamicChartData *dynamic = [[DynamicChartData alloc]initWithNum:@([d.time integerValue]+1) trucks:@(920.0 + [[DynamicChartData generateRandom:(81)] integerValue]) ships: @(910.0 + [[DynamicChartData generateRandom:(91)] integerValue]) planes:@(900.0 + [[DynamicChartData generateRandom:(101)] integerValue])];
    [array addObject:dynamic];

    return array;
}
@end
