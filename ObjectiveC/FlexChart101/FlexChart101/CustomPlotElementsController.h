//
//  CustomPlotElementsController.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPlotElementsController : UIViewController
@end

@interface CustomPoint : NSObject

@property NSString *name;
@property int devicesSold;
@property UIImage *logo;

- (id)initWithName:(NSString*)name devicesSold:(int)devicesSold logo:(UIImage *)logo;

+ (NSMutableArray*)getList;

@end