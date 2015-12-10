//
//  StockData.h
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockData : NSObject

@property NSString *symbol, *name;
//@property NSInteger bidSize, askSize, lastSize, volume;
@property NSNumber *bid, *ask, *lastSale, *change, *bidSize, *askSize, *lastSize, *volume;
@property NSDate *quoteTime, *tradeTime;
+(NSMutableArray *)demoData;
@end
