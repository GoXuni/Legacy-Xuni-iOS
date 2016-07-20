//
//  AutoCompleteData.h
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoCompleteData : NSObject

@property NSString *name;
@property NSString *imageString;

- (id)initWithName:(NSString *)name;

- (id)initWithName:(NSString *)name imageString:(NSString *)imageString;

+ (NSMutableArray *)demoData;
+ (NSMutableArray *)demoData1;

@end
