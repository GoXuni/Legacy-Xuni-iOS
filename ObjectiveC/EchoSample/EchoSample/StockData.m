//
//  StockData.m
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import "StockData.h"

@implementation StockData
+(NSNumber *) generateRandom: (NSInteger) max{
    return [NSNumber numberWithUnsignedInteger:(arc4random()% max)];
}

+(NSMutableArray *) demoData{
 
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"StockSymbols" ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [fileContents componentsSeparatedByString:@"\n"];
    for (int i = 0; i < lines.count; i++) {
        StockData *finance = [[StockData alloc] init];
        NSArray *strings = [lines[i] componentsSeparatedByString:@"\t"];
        finance.symbol = (NSString *)strings[0];
        finance.name = (NSString *)strings[1];
        finance.bid = @([[StockData generateRandom:1001] integerValue]);
        finance.ask = @([[StockData generateRandom:10001] integerValue] + [finance.bid integerValue]);
        finance.lastSale = @([[StockData generateRandom:1001] integerValue]);
        finance.bidSize = @([[StockData generateRandom:491] integerValue] + 10);
        finance.askSize = @([[StockData generateRandom:491] integerValue] + 10);
        finance.lastSize = @([[StockData generateRandom:491] integerValue] + 10);
        finance.volume = @([[StockData generateRandom:10001] integerValue] + 10000);
        finance.quoteTime = [NSDate date];
        finance.tradeTime = [NSDate date];
        if (finance.ask == 0) {
            finance.change = 0;
        }
        else{
            finance.change = @(1.0 - [finance.lastSale floatValue] / [finance.ask floatValue]);
        }
        [array addObject:finance];
    }
    return array;
}
@end
