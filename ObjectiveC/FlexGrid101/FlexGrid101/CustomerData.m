//
//  CustomerData.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomerData.h"

@implementation CountryPair

@end

@implementation CustomerData

-(id)initWithCustomerID:(NSUInteger)customerID countryID:(NSUInteger)countryID firstName:(NSString *)first lastName:(NSString *) last address:(NSString *) address city:(NSString *) city country:(NSString *) country postalCode:(NSString *) postalCode lastOrderDate:(NSDate *)lastOrderDate orderCount:(NSUInteger) orderCount orderTotal:(double)orderTotal active: (BOOL) active
{
    self = [super init];
    if(self){
        _customerID = customerID;
        _countryID = countryID;
        _firstName = first;
        _lastName = last;
        _active = active;
        _address = address;
        _city = city;
        _country = country;
        _postalCode = postalCode;
        _lastOrderDate = lastOrderDate;
        _orderCount = orderCount;
        _orderTotal = orderTotal;
    }
    return self;
}


+(NSUInteger) generateRandom: (NSUInteger) max{
    return arc4random()% max;
}
+(BOOL)generateRandomBool{
    int random = (arc4random() % ((unsigned)RAND_MAX+1));
    if (random % 5 == 0) {
        return true;
    }
    else{
        return false;
    }
}

+ (NSArray *)defaultCountries {
    NSString *countries = @"China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar";
    NSArray *countriesArray = [countries componentsSeparatedByString:@"|"];
    
    NSMutableArray* result = [[NSMutableArray alloc]init];
    for (NSString* country in countriesArray) {
        CountryPair* pair = [[CountryPair alloc]init];
        pair.title = country;
        pair.identifier = @([countriesArray indexOfObject:country]);
        [result addObject:pair];
    }
    
    return result;
}

+(NSMutableArray *) getCustomerData: (NSInteger) total{
    NSString *firstNames = @"Andy|Ben|Charlie|Dan|Ed|Fred|Gil|Herb|Jack|Karl|Larry|Mark|Noah|Oprah|Paul|Quince|Rich|Steve|Ted|Ulrich|Vic|Xavier|Zeb";
    NSArray *firstNamesArray = [firstNames componentsSeparatedByString:@"|"];
    NSString *lastNames = @"Ambers|Bishop|Cole|Danson|Evers|Frommer|Griswold|Heath|Jammers|Krause|Lehman|Myers|Neiman|Orsted|Paulson|Quaid|Richards|Stevens|Trask|Ulam";
    NSArray *lastNamesArray = [lastNames componentsSeparatedByString:@"|"];
    NSString *countries = @"China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar";
    NSArray *countriesArray = [countries componentsSeparatedByString:@"|"];
    
    NSString *cities = @"Honolulu|Los Angeles|San Francisco|Las Vegas|Cancun|Chicago|New York|San Paolo|Miami|Dublin|London|Paris|Addis-Abeba|St. Petersburg|Frankfurt|Istanbul|Isfahan|Cairo|Milano|New Delhi|Bangalor|Mumbai|Dhaka|Tokyo|Osaka|Bangkok|Yangon|Manila";
    NSArray *citiesArray = [cities componentsSeparatedByString:@"|"];
    
    NSString *streets = @"1st St.|Victory St.|Central Ave.|822th St.";
    NSArray *streetsArray = [streets componentsSeparatedByString:@"|"];
    
    NSString *emails = @"info@google.com|info@apple.com|info@microsoft.com|info@samsung.com|info@oracle.com";
    NSArray *emailsArray = [emails componentsSeparatedByString:@"|"];

    
    NSDate *now = [NSDate date];
    NSDate *previousDate;
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < total; i++) {
        dateComps.day = ([CustomerData generateRandom:1000] * -1);
        previousDate = [calendar dateByAddingComponents:dateComps toDate:now options:false];
        CustomerData *customer = [[CustomerData alloc] init];
        customer.customerID = i;
        customer.countryID = [CustomerData generateRandom:[countriesArray count]];
        customer.country = [countriesArray objectAtIndex:customer.countryID];
        customer.firstName = [firstNamesArray objectAtIndex:[CustomerData generateRandom:[firstNamesArray count]]];
        customer.lastName = [lastNamesArray objectAtIndex:[CustomerData generateRandom:[lastNamesArray count]]];
        customer.city = [citiesArray objectAtIndex:[CustomerData generateRandom:[citiesArray count]]];
        customer.address = [streetsArray objectAtIndex:[CustomerData generateRandom:[streetsArray count]]];
        customer.postalCode = [NSString stringWithFormat:@"%lu%lu%lu%lu%lu", [self generateRandom:9], [self generateRandom:9],[self generateRandom:9],[self generateRandom:9],[self generateRandom:9]];
        customer.lastOrderDate = previousDate;
        customer.email = [emailsArray objectAtIndex:[CustomerData generateRandom:[emailsArray count]]];
        customer.orderCount = [self generateRandom:100];
        customer.orderTotal = [self generateRandom:100]/100.0+[self generateRandom:90000];
        customer.active = [CustomerData generateRandomBool];
        [array addObject:customer];
    }
    return array;
}


@end
