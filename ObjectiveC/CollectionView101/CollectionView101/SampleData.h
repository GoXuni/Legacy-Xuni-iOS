//
//  SampleData.h
//  CollectionView101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleData : NSObject

@property NSString* title;
@property NSString* subtitle;
@property NSString* thumbnail;
@property NSString* link;
@property NSString* channelTitle;

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle;

@end
