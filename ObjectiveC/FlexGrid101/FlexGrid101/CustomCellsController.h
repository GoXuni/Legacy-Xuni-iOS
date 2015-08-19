//
//  CustomCellsController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlexGridKit/FlexGridKit.h>

@interface CustomCellsController : UIViewController<FlexGridDelegate>

- (void)formatItem:(FlexFormatItemEventArgs*)args;

@end
