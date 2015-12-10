//
//  XuniWeatherController.h
//  XuniExplorer
//
//  Created by kelley.ricker on 10/15/15.
//  Copyright © 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XuniFlexChartKit/XuniFlexChartKit.h>

@interface XuniWeatherController : UIViewController<UITextFieldDelegate, FlexChartDelegate>

@end

@interface MyMarkerView : XuniChartMarkerBaseView

@property (nonatomic) XuniChartLineMarker *lineMarker;
@property (nonatomic) UILabel *content;

- (id)initWithLineMarker:(XuniChartLineMarker *)lineMarker;

@end

@interface MyChartMarkerRender : NSObject<IXuniChartMarkerRender>

- (id)initWithView:(XuniChartMarkerBaseView *)view;

@end
