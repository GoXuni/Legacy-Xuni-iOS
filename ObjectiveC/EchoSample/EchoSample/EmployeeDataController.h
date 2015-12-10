//
//  EmployeeDataController.h
//  EchoSample
//
//  Created by kelley.ricker on 11/10/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniFlexGridKit/XuniFlexGridKit.h>

@interface EmployeeDataController : UIViewController<FlexGridDelegate>
@property FlexGrid *flex;
@end