//
//  HitTestData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "HitTestData.h"
#import "math.h"

@implementation HitTestData
-(id)initWithX:(NSNumber *)x Y:(NSNumber *)y{
    self = [super init];
    if(self){
        _x = x;
        _y = y;
    }
    return self;
}


+(NSMutableArray *) cosData{
    NSMutableArray *cosData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 40; i++) {
        HitTestData *cosPoint = [[HitTestData alloc]initWithX:@(i) Y:@(cos(i * 0.12))];
        [cosData addObject:cosPoint];
    }
    return cosData;
}
+(NSMutableArray *) sinData{
    NSMutableArray *sinData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 40; i++) {
        HitTestData *sinPoint = [[HitTestData alloc]initWithX:@(i) Y:@(sin(i * 0.12))];
        [sinData addObject:sinPoint];
    }
    return sinData;
}

@end
