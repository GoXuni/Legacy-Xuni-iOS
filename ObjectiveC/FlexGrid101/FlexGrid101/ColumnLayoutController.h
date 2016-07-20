//
//  ColumnLayoutController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "CustomerData.h"

#import "ColumnReordererTableViewController.h"


@interface ColumnLayoutController : UIViewController
@property (weak, nonatomic) IBOutlet FlexGrid *flex;
@end