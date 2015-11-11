//
//  ConditionalFormattingController.h
//  FlexGrid101
//
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XuniFlexGridKit/XuniFlexGridKit.h"

@interface ConditionalFormattingController : UIViewController<FlexGridDelegate>

- (void)formatItem:(FlexFormatItemEventArgs*)args;

@end
