//
//  ChartData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ChartData.h"

@implementation ChartData
-(id)initWithName:(NSString *)name sales: (NSNumber *)sales expenses: (NSNumber *)expenses downloads: (NSNumber *)downloads{
    self = [super init];
    if(self){
        _name = name;
        _sales = sales;
        _expenses = expenses;
        _downloads = downloads;
    }
    return self;
}
+(NSNumber *) generateRandom: (NSInteger) max{
    return [NSNumber numberWithUnsignedInteger:(arc4random()% max)];
}

+(NSMutableArray *) demoData{
    ChartData *US = [[ChartData alloc] initWithName:@"US" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Germany = [[ChartData alloc] initWithName:@"Germany" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *UK = [[ChartData alloc] initWithName:@"UK" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Japan = [[ChartData alloc] initWithName:@"Japan" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Italy = [[ChartData alloc] initWithName:@"Italy" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Greece = [[ChartData alloc] initWithName:@"Greece" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    return [[NSMutableArray alloc] initWithObjects:US, Germany, UK, Japan, Italy, Greece, nil];
}
@end
