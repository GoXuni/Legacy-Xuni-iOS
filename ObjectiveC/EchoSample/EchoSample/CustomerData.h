//
//  CustomerData.h
//  XuniExplorer
//
//  Created by kelley.ricker on 10/22/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerData : NSObject
@property NSNumber *customerID, *countryID, *weight;
@property NSString *first, *last, *father, *brother, *cousin;
@property BOOL active;
@property NSDate *hireDate;

-(id)initWithCustomerID:(NSNumber *)customerID countryID:(NSNumber *)countryID weight:(NSNumber *)weight firstName:(NSString *)first lastName:(NSString *) last father:(NSString *) father brother:(NSString *) brother cousin:(NSString *) cousin active: (BOOL) active hireDate:(NSDate *) hireDate;

+(NSMutableArray *) getCustomerData: (NSInteger) count;

@end
