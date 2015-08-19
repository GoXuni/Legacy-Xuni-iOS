//
//  CustomerData.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomerData.h"

@implementation CustomerData

-(id)initWithCustomerID:(NSNumber *)customerID countryID:(NSNumber *)countryID weight:(NSNumber *)weight firstName:(NSString *)first lastName:(NSString *) last father:(NSString *) father brother:(NSString *) brother cousin:(NSString *) cousin active: (BOOL) active hireDate:(NSDate *) hireDate{
    self = [super init];
    if(self){
        _customerID = customerID;
        _countryID = countryID;
        _weight = weight;
        _first = first;
        _last = last;
        _father = father;
        _brother = brother;
        _cousin = cousin;
        _active = active;
        _hireDate = hireDate;
    }
    return self;
}

+(NSNumber *) generateRandom: (NSUInteger) max{
    return [NSNumber numberWithUnsignedInteger:(arc4random()% max)];
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

+(NSMutableArray *) getCustomerData: (NSInteger) total{
    NSString *firstNames = @"Andy|Ben|Charlie|Dan|Ed|Fred|Gil|Herb|Jack|Karl|Larry|Mark|Noah|Oprah|Paul|Quince|Rich|Steve|Ted|Ulrich|Vic|Xavier|Zeb";
    NSArray *firstNamesArray = [firstNames componentsSeparatedByString:@"|"];
    NSString *lastNames = @"Ambers|Bishop|Cole|Danson|Evers|Frommer|Griswold|Heath|Jammers|Krause|Lehman|Myers|Neiman|Orsted|Paulson|Quaid|Richards|Stevens|Trask|Ulam";
    NSArray *lastNamesArray = [lastNames componentsSeparatedByString:@"|"];
    NSString *countries = @"China|India|United States|Indonesia|Brazil|Pakistan|Bangladesh|Nigeria|Russia|Japan|Mexico|Philippines|Vietnam|Germany|Ethiopia|Egypt|Iran|Turkey|Congo|France|Thailand|United Kingdom|Italy|Myanmar";
    NSArray *countriesArray = [countries componentsSeparatedByString:@"|"];
    NSDate *now = [NSDate date];
    NSDate *previousDate;
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < total; i++) {
        dateComps.day = ([[CustomerData generateRandom:1000] integerValue]* -1);
        previousDate = [calendar dateByAddingComponents:dateComps toDate:now options:false];
        CustomerData *customer = [[CustomerData alloc] init];
        customer.customerID = @(i);
        customer.countryID = @([[CustomerData generateRandom:[countriesArray count]] integerValue]);
        customer.weight = @(100 +[[CustomerData generateRandom:150] integerValue]);
        customer.first = [firstNamesArray objectAtIndex:[[CustomerData generateRandom:[firstNamesArray count]] integerValue]];
        customer.last = [lastNamesArray objectAtIndex:[[CustomerData generateRandom:[lastNamesArray count]] integerValue]];
        customer.father = [firstNamesArray objectAtIndex:[[CustomerData generateRandom:[firstNamesArray count]] integerValue]];
        customer.brother = [firstNamesArray objectAtIndex:[[CustomerData generateRandom:[firstNamesArray count]] integerValue]];
        customer.cousin = [firstNamesArray objectAtIndex:[[CustomerData generateRandom:[firstNamesArray count]] integerValue]];
        customer.active = [CustomerData generateRandomBool];
        customer.hireDate = previousDate;
        [array addObject:customer];
    }
    return array;
}


@end
