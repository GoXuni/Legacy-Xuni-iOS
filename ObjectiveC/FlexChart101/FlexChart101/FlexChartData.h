//
//  FlexChartData.h
//  FlexChart101
//
//  Created by Evangelists on 6/1/15.
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlexChartData : NSObject


@property NSString *name;
@property NSNumber *value;

-(id)initWithName: (NSString *)name value: (NSNumber *)value;

+(NSMutableArray *)demoData;

@end
