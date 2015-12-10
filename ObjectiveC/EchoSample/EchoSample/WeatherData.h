//
//  WeatherData.h
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
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