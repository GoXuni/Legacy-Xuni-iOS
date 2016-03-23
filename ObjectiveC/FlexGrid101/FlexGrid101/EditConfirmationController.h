//
//  EditConfirmationController.h
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XuniFlexGridKit/XuniFlexGridKit.h"
@interface EditConfirmationController : UIViewController<FlexGridDelegate>


-(bool)beginningEdit:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range;
-(bool)cellEditEnding:(FlexGrid *)sender panel:(FlexGridPanel *)panel forRange:(FlexCellRange *)range cancel:(BOOL)cancel;


@end
