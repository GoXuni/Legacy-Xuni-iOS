//
//  ChartAnnotationsController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "ChartAnnotationsController.h"

#import "ChartData.h"
#import "XuniFlexChartKit/XuniFlexChartKit.h"

@interface ChartAnnotationsController ()

@end

@implementation ChartAnnotationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Annotations"];
    
    // Do any additional setup after loading the view.
    FlexChart *chart = [[FlexChart alloc] init];
    NSMutableArray *chartData = [ChartData annotationData];
    chart.bindingX = @"name";
    chart.chartType = XuniChartTypeLine;
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    [chart.series addObject:sales];
    chart.itemsSource = chartData;
    [self addAnnotations:chart];
    
    chart.tag = 1;
    [self.view addSubview:chart];
}

- (void)addAnnotations:(FlexChart *)chart {
    // Polygon annotation.
    XuniChartPolygonAnnotation *polygon = [[XuniChartPolygonAnnotation alloc] initWithChart:chart];
    polygon.isVisible = YES;
    polygon.attachment = XuniChartAnnotationAttachmentAbsolute;
    polygon.color = [UIColor redColor];
    polygon.borderColor = [UIColor colorWithRed:20.0 / 255.0 green:153.0 / 255.0 blue:212.0 / 255.0 alpha:1.0];
    polygon.borderWidth = 2;
    polygon.textColor = [UIColor blackColor];
    polygon.text = @"Absolute";
    polygon.tooltipText = @"Polygon Annotation\nPaths:[{0,0},{40,40},{80,0},\n{60,-40},{20,-40}]\nAttachment:Absolute";
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:[[XuniPoint alloc] initX:60 Y:40]];
    [arr addObject:[[XuniPoint alloc] initX:20 Y:80]];
    [arr addObject:[[XuniPoint alloc] initX:35 Y:120]];
    [arr addObject:[[XuniPoint alloc] initX:85 Y:120]];
    [arr addObject:[[XuniPoint alloc] initX:100 Y:80]];
    polygon.points = arr;
    
    // Ellipse annotation.
    XuniChartEllipseAnnotation *ellipse = [[XuniChartEllipseAnnotation alloc] initWithChart:chart];
    ellipse.isVisible = YES;
    ellipse.position = XuniChartAnnotationPositionCenter;
    ellipse.attachment = XuniChartAnnotationAttachmentRelative;
    ellipse.width = 60;
    ellipse.height = 40;
    ellipse.point = [[XuniPoint alloc] initX:0.8 Y:0.3];
    ellipse.color = [UIColor colorWithRed:241.0 / 255.0 green:175.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
    ellipse.borderColor = [UIColor colorWithRed:188.0 / 255.0 green:136.0 / 255.0 blue:80.0 / 255.0 alpha:1.0];
    ellipse.borderWidth = 2;
    ellipse.text = @"Relative";
    ellipse.tooltipText = @"Ellipse Annotation\nPoint:{0.8,0.3}\nAttachment:Relative";
    
    // Line annotation.
    double middleY = (chart.axisY.actualDataMax - chart.axisY.actualDataMin) / 2 + chart.axisY.actualDataMin;
    XuniChartLineAnnotation *line = [[XuniChartLineAnnotation alloc] initWithChart:chart];
    line.isVisible = YES;
    line.attachment = XuniChartAnnotationAttachmentDataCoordinate;
    line.start = [[XuniPoint alloc] initX:0 Y:middleY];
    line.end = [[XuniPoint alloc] initX:chart.axisX.actualDataMax Y:middleY];
    line.color = [UIColor blueColor];
    line.lineWidth = 3;
    
    // Text annotation.
    XuniChartTextAnnotation *text = [[XuniChartTextAnnotation alloc] initWithChart:chart];
    text.isVisible = YES;
    text.position = XuniChartAnnotationPositionRight;
    text.attachment = XuniChartAnnotationAttachmentDataCoordinate;
    text.width = 80;
    text.height = 20;
    text.point = [[XuniPoint alloc] initX:0.3 Y:middleY + 200];
    text.font = [UIFont boldSystemFontOfSize:12.0];
    text.text = @"Data Coordinate";
    
    // Image annotation.
    XuniChartImageAnnotation *image = [[XuniChartImageAnnotation alloc] initWithChart:chart];
    image.isVisible = YES;
    image.position = XuniChartAnnotationPositionCenter;
    image.attachment = XuniChartAnnotationAttachmentDataIndex;
    image.seriesIndex = 0;
    image.pointIndex = 2;
    image.width = 50;
    image.height = 50;
    image.offset = [[XuniPoint alloc] initX:0 Y:10];
    image.source = [UIImage imageNamed:@"xuni_butterfly"];
    image.tooltipText = @"Image Annotation\nPointIndex:{2}\nAttachment:DataIndex";
    
    // Rectangle annotation.
    XuniChartRectangleAnnotation *rect = [[XuniChartRectangleAnnotation alloc] initWithChart:chart];
    rect.isVisible = YES;
    rect.position = XuniChartAnnotationPositionCenter;
    rect.attachment = XuniChartAnnotationAttachmentDataIndex;
    rect.seriesIndex = 0;
    rect.pointIndex = 6;
    rect.width = 100;
    rect.height = 50;
    rect.color = [UIColor colorWithRed:169.0 / 255.0 green:230.0 / 255.0 blue:24.0 / 255.0 alpha:1.0];
    rect.borderColor = [UIColor colorWithRed:34.0 / 255.0 green:166.0 / 255.0 blue:60.0 / 255.0 alpha:1.0];
    rect.borderWidth = 2;
    rect.text = @"DataIndex";
    rect.tooltipText = @"Rectangle Annotation\nPointIndex:{6}\nAttachment:DataIndex";
    
    // Add annotations to chart.
    [chart.annotations addObject:polygon];
    [chart.annotations addObject:ellipse];
    [chart.annotations addObject:line];
    [chart.annotations addObject:text];
    [chart.annotations addObject:image];
    [chart.annotations addObject:rect];
    
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
