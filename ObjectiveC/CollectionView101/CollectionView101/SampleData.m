//
//  SampleData.m
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "SampleData.h"

@implementation SampleData
- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}
@end
