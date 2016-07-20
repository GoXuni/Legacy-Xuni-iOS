//
//  SharedFilterData.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FilterData.h"

@implementation FilterData

+(NSMutableArray *)sharedFilterData{
    static NSMutableArray *sharedInstance = nil;
    
    @synchronized(self){
        if(!sharedInstance){
            sharedInstance = [[NSMutableArray alloc] init];
        }
    }
    return sharedInstance;
}

@end

@implementation FilterOperation
+ (NSArray *)defaultOperations {
    NSString *operations = @"Contains|StartsWith|EndsWith|EqualsText";
    NSArray *operationsArray = [operations componentsSeparatedByString:@"|"];
    
    NSMutableArray* result = [[NSMutableArray alloc]init];
    for (NSString* operation in operationsArray) {
        FilterOperation* oper = [[FilterOperation alloc]init];
        oper.title = operation;
        oper.identifier = [operationsArray indexOfObject:operation];
        [result addObject:oper];
    }
    
    return result;
}
@end

