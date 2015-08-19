//
//  WeatherData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "WeatherData.h"
#import "math.h"

@implementation WeatherData

-(id)initWithMonthName:(NSString *)monthName temp:(NSNumber *)temp precipitation:(NSNumber *)precipitation{
    self = [super init];
    if(self){
        _monthName = monthName;
        _temp = temp;
        _precipitation = precipitation;

    }
    return self;
}
+(NSNumber *) generateRandom: (NSInteger) max{
    return [NSNumber numberWithUnsignedInteger:(arc4random()% max)];
}

+(NSMutableArray *) demoData{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *monthNames = [[NSMutableArray alloc] initWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    for (int i = 0; i < [monthNames count]; i++) {
        WeatherData *weather = [[WeatherData alloc]initWithMonthName:[monthNames objectAtIndex:i] temp:@((tan(i*i)) + 70) precipitation:@([[self generateRandom:11] integerValue] + 8)];
        [array addObject:weather];
    }
    return array;
}
@end
