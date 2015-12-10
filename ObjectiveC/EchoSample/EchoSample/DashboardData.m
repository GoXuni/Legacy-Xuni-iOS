//
//  DashboardData.m
//  XuniExplorer
//
//  Created by kelley.ricker on 10/30/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "DashboardData.h"

@implementation DashboardData

-(id)initWithSales:(NSNumber *)sales downloads:(NSNumber *)downloads expenses:(NSNumber *)expenses quarter:(NSString *)quarter{
    self = [super init];
    if(self){
        _sales = sales;
        _downloads = downloads;
        _expenses= expenses;
        _quarter = quarter;
        
    }
    return self;
}

+(NSMutableArray*) demoData{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    DashboardData *quarter1 = [[DashboardData alloc]initWithSales:@6833 downloads:@8500 expenses:@11166 quarter:@"Q1"];
    DashboardData *quarter2 = [[DashboardData alloc]initWithSales:@11100 downloads:@7933 expenses:@10166 quarter:@"Q2"];
    DashboardData *quarter3 = [[DashboardData alloc]initWithSales:@10833 downloads:@11166 expenses:@7333 quarter:@"Q3"];
    DashboardData *quarter4 = [[DashboardData alloc]initWithSales:@15250 downloads:@12350 expenses:@8166 quarter:@"Q4"];
    
    [array addObject:quarter1];
    [array addObject:quarter2];
    [array addObject:quarter3];
    [array addObject:quarter4];
    
    return array;
}

@end
