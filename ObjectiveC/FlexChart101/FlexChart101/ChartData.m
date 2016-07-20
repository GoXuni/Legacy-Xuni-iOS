//
//  ChartData.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ChartData.h"

@implementation ChartData

- (id)initWithName:(NSString *)name sales:(NSNumber *)sales expenses:(NSNumber *)expenses downloads:(NSNumber *)downloads {
    self = [super init];
    if(self){
        _name = name;
        _sales = sales;
        _expenses = expenses;
        _downloads = downloads;
    }
    return self;
}   
+ (NSNumber *)generateRandom:(NSInteger) max {
    return [NSNumber numberWithUnsignedInteger:(arc4random() % max)];
}

+ (NSMutableArray *)demoData {
    ChartData *US = [[ChartData alloc] initWithName:@"US" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Germany = [[ChartData alloc] initWithName:@"Germany" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *UK = [[ChartData alloc] initWithName:@"UK" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Japan = [[ChartData alloc] initWithName:@"Japan" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Italy = [[ChartData alloc] initWithName:@"Italy" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Greece = [[ChartData alloc] initWithName:@"Greece" sales:[ChartData generateRandom : 10001] expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    return [[NSMutableArray alloc] initWithObjects:US, Germany, UK, Japan, Italy, Greece, nil];
}

+ (NSMutableArray *)annotationData {
    ChartData *US = [[ChartData alloc] initWithName:@"US" sales:@1500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Germany = [[ChartData alloc] initWithName:@"Germany" sales:@4000 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *UK = [[ChartData alloc] initWithName:@"UK" sales:@3000 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Japan = [[ChartData alloc] initWithName:@"Japan" sales:@6000 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Italy = [[ChartData alloc] initWithName:@"Italy" sales:@3500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Greece = [[ChartData alloc] initWithName:@"Greece" sales:@8500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *France = [[ChartData alloc] initWithName:@"France" sales:@2300 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Spain = [[ChartData alloc] initWithName:@"Spain" sales:@6500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Ireland = [[ChartData alloc] initWithName:@"Ireland" sales:@4500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    ChartData *Poland = [[ChartData alloc] initWithName:@"Poland" sales:@9500 expenses:[ChartData generateRandom : 5001] downloads:[ChartData generateRandom : 20001]];
    
    return [[NSMutableArray alloc] initWithObjects:US, Germany, UK, Japan, Italy, Greece, France, Spain, Ireland, Poland, nil];
}

@end

@implementation ChartPoint

- (id)initWithX:(NSNumber*)x y:(NSNumber*)y {
    self = [super init];
    if(self){
        _x = x;
        _y = y;
    }
    return self;
}

+ (NSMutableArray *)generateRandomPoints:(NSInteger)count {
    NSMutableArray *points = [[NSMutableArray alloc] init];
    
    if (count % 2 == 1) {
        count++;
    }

    for (int i = 0; i < count / 2; i++) {
        do
        {
            double random = rand() / (double)RAND_MAX;
            double u = 2 * random - 1;
            double v = 2 * random - 1;
            
            double s = u * u + v * v;
            
            if (s < 1)
            {
                s = sqrt(-2 * log(s) / s);
                [points addObject:[[ChartPoint alloc] initWithX:[NSNumber numberWithInt:i]
                                                              y:[NSNumber numberWithDouble:u * s]]];
                [points addObject:[[ChartPoint alloc] initWithX:[NSNumber numberWithInt:i + 1]
                                                              y:[NSNumber numberWithDouble:v * s]]];
                break;
            }
        } while (true);
    }
    
    return points;
}

+ (NSMutableArray *)generateRandomData:(NSInteger)count {
    NSMutableArray *points = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count ; i++) {
        double random = arc4random()%10000 + 100;
        [points addObject:[[ChartPoint alloc] initWithX:[NSNumber numberWithInt:i*10]
        y:[NSNumber numberWithDouble:random]]];
    }
    
    return points;
}

@end