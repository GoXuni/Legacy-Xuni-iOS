//
//  WeatherData.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData
-(id)initWithDate:(NSDate *)date weatherDescription:(NSString *) weatherDescription highTemp:(NSNumber *)highTemp lowTemp:(NSNumber *)lowTemp humidity:(NSNumber *)humidity pressure:(NSNumber *)pressure{
    self = [super init];
    if(self){
        _date = date;
        _weatherDescription = weatherDescription;
        _highTemp = highTemp;
        _lowTemp = lowTemp;
        _humidity = humidity;
        _pressure = pressure;
    }
    return self;
}

+(NSMutableArray *) demoData: (NSString *) location{
    NSData *data;
    if ([location isEqualToString:@"OfflineWeatherData"]) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"OfflineWeatherData" ofType:@"json"];
        data = [[NSData alloc]initWithContentsOfFile:filepath];
    }
    
    else{
        NSString *urlpath = [[@"http://api.openweathermap.org/data/2.5/forecast?zip=" stringByAppendingString:location] stringByAppendingString:@"&units=imperial&APPID=a0a0e5e6d1ded0c79e853990c86f957b"];
        NSURLRequest *requestForWeatherData = [NSURLRequest requestWithURL:[NSURL URLWithString:urlpath]];
        NSURLResponse *response = nil;
        NSError *error = nil;
        data = [NSURLConnection sendSynchronousRequest:requestForWeatherData returningResponse:&response error:&error];
    }
    
    NSError *error = nil;
    
    NSMutableDictionary *fullData = [ NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    NSArray* forecastList = fullData[@"list"];
    NSDictionary *temp = [[NSDictionary alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSDictionary* forecastDictionary in forecastList) {
        
        WeatherData *forecastData = [[WeatherData alloc] init];
        NSArray *weather = forecastDictionary[@"weather"];
        temp = forecastDictionary[@"main"];
        
        forecastData.date = [dateFormatter dateFromString:(NSString *)forecastDictionary[@"dt_txt"]];
        forecastData.highTemp = temp[@"temp_max"];
        forecastData.lowTemp = temp[@"temp_min"];
        forecastData.humidity = temp[@"humidity"];
        forecastData.pressure = temp[@"pressure"];
        
        for (NSDictionary* weatherDictionary in weather) {
            forecastData.weatherDescription = weatherDictionary[@"description"];
        }
        
        [array addObject:forecastData];
    }
    
    return array;
}

@end
