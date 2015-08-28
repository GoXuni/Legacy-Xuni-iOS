//
//  WeatherData.h
//  XuniWeather
//
//  Created by Chris Ripple on 8/26/15.
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

@property NSDate *date;
@property NSString *weatherDescription;
@property NSNumber *highTemp;
@property NSNumber *lowTemp;
@property NSNumber *humidity;
@property NSNumber *pressure;

+(NSMutableArray *)demoData: (NSString *) location;

-(id)initWithDate:(NSDate *)date weatherDescription:(NSString *) weatherDescription highTemp:(NSNumber *)highTemp lowTemp:(NSNumber *)lowTemp humidity:(NSNumber *)humidity pressure:(NSNumber *)pressure;

@end
