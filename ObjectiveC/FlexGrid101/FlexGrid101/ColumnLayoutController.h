//
//  ColumnLayoutController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "CustomerData.h"

#import "ColumnReordererTableViewController.h"


@interface ColumnLayoutController : UIViewController
@property FlexGrid* flex;
@end


extern ColumnLayoutController* columnLayoutController;