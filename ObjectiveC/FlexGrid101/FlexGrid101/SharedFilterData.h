//
//  SharedFilterData.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedFilterData : NSObject{
    BOOL filterSet;
    NSNumber *filterOperation;
    NSString *filterString;
}

@property(nonatomic) BOOL filterSet;
@property(nonatomic) NSNumber *filterOperation;
@property(nonatomic) NSString *filterString;

+(SharedFilterData *) sharedInstance;

@end
