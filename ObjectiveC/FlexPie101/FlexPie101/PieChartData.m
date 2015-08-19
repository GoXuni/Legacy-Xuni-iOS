//
//  PieChartData.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "PieChartData.h"

@implementation PieChartData

-(id)initWithName:(NSString *)name value:(NSNumber *)value{
    self = [super init];
    if(self){
        _name = name;
        _value = value;
    }
    return self;
}

+(NSMutableArray *) demoData{
    PieChartData *Oranges = [[PieChartData alloc] initWithName:@"Oranges" value:[NSNumber numberWithUnsignedInteger:(arc4random()%101)]];
    PieChartData *Apples = [[PieChartData alloc] initWithName:@"Apples" value:[NSNumber numberWithUnsignedInteger:(arc4random()%101)]];
    PieChartData *Pears = [[PieChartData alloc] initWithName:@"Pears" value:[NSNumber numberWithUnsignedInteger:(arc4random()%101)]];
    PieChartData *Bananas = [[PieChartData alloc] initWithName:@"Bananas" value:[NSNumber numberWithUnsignedInteger:(arc4random()%101)]];
    PieChartData *Pineapples = [[PieChartData alloc] initWithName:@"Pineapples" value:[NSNumber numberWithUnsignedInteger:(arc4random()%101)]];
    return [[NSMutableArray alloc] initWithObjects:Oranges, Apples, Pears, Bananas, Pineapples, nil];
}
@end
