//
//  CustomTooltipsController.h
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import <UIKit/UIKit.h>
@import XuniChartCoreDynamicKit;

@interface CustomTooltipsController : UIViewController

@end

@interface MyTooltip : XuniBaseChartTooltipView

-(void)setChartData:(XuniDataPoint *)chartData;

-(void)_render;

@end