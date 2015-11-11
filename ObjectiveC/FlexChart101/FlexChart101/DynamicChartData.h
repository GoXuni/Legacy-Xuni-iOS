//
//  DynamicChartData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DynamicChartData : NSObject

@property NSString *time;
@property NSNumber *trucks;
@property NSNumber *ships;
@property NSNumber *planes;


-(id)initWithNum:(NSString *)time trucks:(NSNumber *)trucks ships:(NSNumber *)ships planes:(NSNumber *)planes;

+(NSMutableArray *)demoData;
+(NSMutableArray *)dynamicData: (NSMutableArray *) array;

@end
