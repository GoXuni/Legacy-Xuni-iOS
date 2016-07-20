//
//  EditingFormController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "CustomerData.h"


@interface EditingFormController : UIViewController

@property CustomerData* edited;

-(void)cancel;
-(void)confirm;
@end