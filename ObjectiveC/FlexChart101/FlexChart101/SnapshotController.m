//
//  SnapshotController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SnapshotController.h"
#import "FlexChartKit/FlexChartKit.h"
#import "ChartData.h"

@interface SnapshotController ()

@end

@implementation SnapshotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *snapshotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [snapshotButton setTitle:@"Take a snapshot" forState:UIControlStateNormal];
    [snapshotButton addTarget:self action:@selector(snapshotButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
    chart.axisX.labelsVisible = true;
    chart.axisY.labelsVisible = true;
    
    chart.legend.orientation = XuniChartLegendOrientationAuto;
    chart.legend.position = XuniChartLegendPositionAuto;
    chart.tooltip.visible = true;
    
    chart.tag = 1;
    snapshotButton.tag = 2;
    
    [self.view addSubview:chart];
    [self.view addSubview:snapshotButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIButton *snapshotButton = (UIButton*)[self.view viewWithTag:2];
    chart.frame = CGRectMake(5, 115, self.view.bounds.size.width-10, self.view.bounds.size.height-115);
    snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);
    [chart setNeedsDisplay];
}

-(void)snapshotButtonClicked{
    FlexChart *chart = (FlexChart*)[self.view viewWithTag:1];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[chart getImage]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
}
-(void)imageSavedToPhotoAlbum:(UIImage *)image finishedSavingWithError: (NSError *)error contextInfo:(void *)contextInfo{
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"Succes";
        message = @"Image was saved to Camera Roll succesfully";
    }
    else{
        title = @"Failure";
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
