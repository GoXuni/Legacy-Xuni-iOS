//
//  SnapshotController.m
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SnapshotController.h"
@import XuniFlexChartDynamicKit;
#import "ChartData.h"

@interface SnapshotController ()
@property (weak, nonatomic) IBOutlet FlexChart *chart;

@end

@implementation SnapshotController
- (IBAction)doSnapshot:(id)sender {
    FlexChart *chart = self.chart;
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[chart getImage]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FlexChart *chart = self.chart;
    XuniSeries *sales = [[XuniSeries alloc] initForChart:chart binding:@"sales, sales" name:@"Sales"];
    XuniSeries *expenses = [[XuniSeries alloc] initForChart:chart binding:@"expenses, expenses" name:@"Expenses"];
    XuniSeries *downloads = [[XuniSeries alloc] initForChart:chart binding:@"downloads, downloads" name:@"Downloads"];
    
    [chart.series addObject:sales];
    [chart.series addObject:expenses];
    [chart.series addObject:downloads];
    
    chart.bindingX = @"name";
    chart.itemsSource = [ChartData demoData];
    
}


- (void)imageSavedToPhotoAlbum:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message;
    NSString *title;
    
    if (!error) {
        title = NSLocalizedString(@"Success", nil);
        message = NSLocalizedString(@"Image was saved to Camera Roll successfully", nil);
    }
    else {
        title = NSLocalizedString(@"Failure", nil);
        message = [error description];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}


@end
