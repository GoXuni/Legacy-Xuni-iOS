//
//  EmployeeData.h
//  XuniExplorer
//
//  Created by kelley.ricker on 11/4/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmployeeData : NSObject
@property double status;
@property NSDate *hireDate;
@property NSString *name, *title, *thumbnailImage;
@property BOOL fulltime;
@property NSNumber *departmentID;

@end
