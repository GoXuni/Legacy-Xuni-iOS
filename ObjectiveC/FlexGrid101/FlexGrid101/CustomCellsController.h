//
//  CustomCellsController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniFlexGridKit/XuniFlexGridKit.h>

@interface CustomCellsController : UIViewController<FlexGridDelegate>

-(bool)formatItem:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range inContext:(CGContextRef)context;

@end
