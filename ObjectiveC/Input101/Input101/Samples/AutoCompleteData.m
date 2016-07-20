//
//  AutoCompleteData.m
//  XuniInput
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "AutoCompleteData.h"

@implementation AutoCompleteData

- (id)initWithName:(NSString *)name{
    self = [super init];
    if(self){
        _name = name;
    }
    return self;
}

- (id)initWithName:(NSString *)name imageString:(NSString *)imageString{
    self = [super init];
    if(self){
        _name = name;
        _imageString = imageString;
    }
    return self;
}

+ (NSMutableArray *)demoData {
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSArray *array = @[@"Australia",@"Bangladesh",@"Brazil",@"Canada", @"China", @"France",@"Germany",@"India", @"Japan", @"Nepal", @"Pakistan", @"Srilanka"];
    for (int i = 0; i < array.count; i++) {
        AutoCompleteData *data = [[AutoCompleteData alloc]initWithName:array[i]];
        [dataArray addObject:data];
    }
    return dataArray;
    
}

+ (NSMutableArray *)demoData1 {
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    NSArray *textArray = @[@"Australia",@"Bangladesh",@"Brazil",@"Canada", @"China", @"France",@"Germany",@"India", @"Japan", @"Nepal", @"Pakistan", @"Srilanka"];
    NSArray *imageArray = @[@"Australia",@"Bangladesh",@"Brazil",@"Canada", @"China", @"France",@"Germany",@"India", @"Japan", @"Nepal", @"Pakistan", @"Srilanka"];
    for (int i = 0; i < textArray.count; i++) {
        AutoCompleteData *data = [[AutoCompleteData alloc]initWithName:textArray[i] imageString:imageArray[i]];
        [dataArray addObject:data];
    }
    return dataArray;
}

@end
