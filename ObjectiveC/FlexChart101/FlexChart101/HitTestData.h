//
//  HitTestData.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HitTestData : NSObject

@property NSNumber *x;
@property NSNumber *y;

-(id)initWithX: (NSNumber *)x Y: (NSNumber *)y;

+(NSMutableArray *)cosData;

+(NSMutableArray *)sinData;

@end
