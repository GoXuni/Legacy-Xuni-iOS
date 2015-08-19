//
//  WeatherData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

@property NSString *monthName;
@property NSNumber *temp;
@property NSNumber *precipitation;
+(NSMutableArray *)demoData;

@end
