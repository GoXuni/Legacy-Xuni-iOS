//
//  SharedFilterData.m
//  FlexGrid101
//
//  Created by Evangelists on 7/28/15.
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SharedFilterData.h"

@implementation SharedFilterData
{
    SharedFilterData *moreSharedData;
}
@synthesize filterSet;
@synthesize filterOperation;
@synthesize filterString;

+(SharedFilterData *)sharedInstance{
    static SharedFilterData *sharedInstance = nil;
    
    @synchronized(self){
        if(!sharedInstance){
            sharedInstance = [[SharedFilterData alloc] init];
        }
    }
    return sharedInstance;
}

@end
