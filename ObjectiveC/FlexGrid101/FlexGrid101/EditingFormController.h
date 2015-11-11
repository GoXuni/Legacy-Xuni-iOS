//
//  EditingFormController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "CustomerData.h"


@interface EditingFormController : UIViewController<FlexGridDelegate>
-(void)cancel;
-(void)confirm;
@end

extern EditingFormController* efc;
extern CustomerData* edited;