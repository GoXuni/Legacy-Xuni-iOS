//
//  WeatherData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "WeatherData.h"
#import "math.h"

@implementation WeatherData

- (id)initWithMonthName:(NSString *)monthName index:(NSNumber *)index temp:(NSNumber *)temp precipitation:(NSNumber *)precipitation volume:(NSNumber *)volume {
    self = [super init];
    
    if(self){
        _monthName = monthName;
        _index = index;
        _temp = temp;
        _precipitation = precipitation;
        _volume = volume;
    }
    
    return self;
}

+ (NSInteger)randomNumberBetween:(NSInteger)min max:(NSInteger)max {
    return min + rand() % (max - min + 1);
}

+ (NSMutableArray *)demoData {

    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *monthNames = [[NSMutableArray alloc] initWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    for (int i = 0; i < [monthNames count]; i++) {
        WeatherData *weather = [[WeatherData alloc] initWithMonthName:[monthNames objectAtIndex:i]
                                                                index:[NSNumber numberWithInt:i]
                                                                 temp:@([self randomNumberBetween:50 max:80])
                                                        precipitation:@([self randomNumberBetween:1 max:20])
                                                               volume:@([self randomNumberBetween:50 max:80])];
        [array addObject:weather];
    }
    return array;
}
@end
