//
//  DashboardData.h
//  XuniExplorer
//
//  Created by kelley.ricker on 10/30/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DashboardData : NSObject

@property NSNumber *sales, *downloads, *expenses;
@property NSString *quarter;


-(id)initWithSales:(NSNumber *)sales downloads:(NSNumber *)downloads expenses:(NSNumber *)expenses quarter:(NSString *) quarter;

+(NSMutableArray *) demoData;

@end

