//
//  CustomTooltipsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "CustomTooltipsController.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"
#import "XuniChartCoreKit/XuniChartCoreKit.h"
#import "ChartData.h"

@interface CustomTooltipsController (){
    MyTooltip *t;
}
@end

@implementation CustomTooltipsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:NSLocalizedString(@"Custom Tooltips", nil)];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData demoData];
    chart.bindingX = @"name";
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.itemsSource = chartData;
    chart.stacking = XuniStackingStacked;
    chart.palette = [XuniPalettes zen];
    chart.loadAnimation.animationMode = XuniAnimationModeSeries;
    chart.axisY.axisLineVisible = NO;
    chart.axisY.majorUnit = 2000;
    
    t = [[MyTooltip alloc] init];
    t.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.792 alpha:1];
    chart.tooltip.content = t;
    
    chart.tag = 1;
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    chart.frame = CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height - 55);
    [chart setNeedsDisplay];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

@interface MyTooltip (){
    UILabel *label;
    UIImage *image;
    UIImageView *imageView;
    CGFloat tooltipWidth;
    CGFloat tooltipHeight;
}
@end


@implementation MyTooltip

-(void)setChartData:(XuniDataPoint *)chartData{
    XuniChartDataPoint *cdpt = (XuniChartDataPoint *)chartData;
    NSNumber *countryNum = [NSNumber numberWithDouble:cdpt.pointIndex];

    if (label == nil  && imageView == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/4, 0, self.bounds.size.width*3/4, self.bounds.size.height)];
        label.textColor = [UIColor blackColor];

        label.numberOfLines = 3;
        label.text = [NSString stringWithFormat:@"%@ \n\n $%.2f", cdpt.seriesName, cdpt.value];
        label.font = [label.font fontWithSize:11];
        image = [UIImage imageNamed:[countryNum stringValue]];
        imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        [self addSubview:label];
    }
    else{
        image = [UIImage imageNamed:[countryNum stringValue]];
        [imageView setImage:image];
        label.text = [NSString stringWithFormat:@"%@ \n\n $%.2f", cdpt.seriesName, cdpt.value];
        [imageView setNeedsLayout];
        [label setNeedsLayout];
    }
}
-(void)_render{
    //prevents drawing of default tooltip
}
-(CGRect)_getFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint{
        tooltipHeight = 50;
        tooltipWidth = 100;
        if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth  && ([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
        }
        else if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth){
            return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight);
        }
        else if (([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(senderPoint.x, ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
        }
        else{
            return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight);
        }
}
-(CGRect)_getContentFrameRect:(CGRect)contentFrame senderPoint:(CGPoint)senderPoint{
    tooltipHeight = 50;
    tooltipWidth = 100;
    if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth  && ([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
        return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
    }
    else if (([UIScreen mainScreen].bounds.size.width - senderPoint.x) < tooltipWidth){
        return CGRectMake(([UIScreen mainScreen].bounds.size.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight);
    }
    else if (([UIScreen mainScreen].bounds.size.height - senderPoint.y) < tooltipHeight){
        return CGRectMake(senderPoint.x, ([UIScreen mainScreen].bounds.size.height - tooltipHeight), tooltipWidth, tooltipHeight);
    }
    else{
        return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight);
    }
}
@end
