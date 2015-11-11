//
//  UpdateAnimationController.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateAnimationController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

@end

@interface UpdateData : NSObject

@property NSString *xValue;
@property NSNumber *value;

- (id)initWithXValue:(NSString *)xValue y:(NSNumber*)value;

+ (NSArray *)demoData;

@end