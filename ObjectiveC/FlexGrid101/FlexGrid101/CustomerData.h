//
//  CustomerData.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryPair: NSObject
@property NSString* title;
@property NSNumber* identifier;
@end

@interface CustomerData : NSObject
@property NSUInteger customerID;
@property NSString *firstName, *lastName;
@property (nonatomic, readonly) NSString *name;
@property NSString *address, *city;
@property NSUInteger countryID;
@property NSString *country, *postalCode, *email;
@property NSDate *lastOrderDate;
@property NSUInteger orderCount;
@property double orderTotal;
@property (nonatomic, readonly) double orderAverage;
@property BOOL active;

-(id)initWithCustomerID:(NSUInteger)customerID countryID:(NSUInteger)countryID firstName:(NSString *)first lastName:(NSString *) last address:(NSString *) address city:(NSString *) city country:(NSString *) country postalCode:(NSString *) postalCode lastOrderDate:(NSDate *) lastOrderDate orderCount:(NSUInteger) orderCount orderTotal:(double)orderTotal active: (BOOL) active;


+(NSMutableArray *) getCustomerData: (NSInteger) count;
+ (NSArray *)defaultCountries;

///TODO - remove obsolete properties and constructor


/*@property NSNumber *weight;
@property NSString *first, *last, *father, *brother, *cousin;

@property NSDate *hireDate;*/

@end
