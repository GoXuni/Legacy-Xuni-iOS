//
//  LineMarkerController.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniFlexChartKit/XuniFlexChartKit.h>

@interface LineMarkerController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@end

@interface MyMarkerView : XuniChartMarkerBaseView

@property (nonatomic) XuniChartLineMarker *lineMarker;
@property (nonatomic) UILabel *content;

- (id)initWithLineMarker:(XuniChartLineMarker *)lineMarker;

@end

@interface MyChartMarkerRender : NSObject<IXuniChartMarkerRender>

- (id)initWithView:(XuniChartMarkerBaseView *)view;

@end