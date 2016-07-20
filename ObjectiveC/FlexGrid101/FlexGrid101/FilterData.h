//
//  SharedFilterData.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterOperation: NSObject
@property NSString* title;
@property int identifier;

+ (NSArray *)defaultOperations;
@end

@interface FilterData : NSObject

@property NSString *filterColumn;
@property int filterOperation;
@property NSString *filterString;

+(NSMutableArray *) sharedFilterData;

@end
