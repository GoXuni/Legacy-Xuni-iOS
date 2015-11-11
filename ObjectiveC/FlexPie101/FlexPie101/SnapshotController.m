//
//  SnapshotController.m
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SnapshotController.h"
#import "XuniFlexPieKit/XuniFlexPieKit.h"
#import "PieChartData.h"

@interface SnapshotController ()

@end

@implementation SnapshotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *snapshotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [snapshotButton setTitle:@"Take a snapshot" forState:UIControlStateNormal];
    [snapshotButton addTarget:self action:@selector(snapshotButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    FlexPie *pieChart = [[FlexPie alloc] init];
    NSMutableArray *pieData = [PieChartData demoData];
    pieChart.binding = @"value";
    pieChart.bindingName = @"name";
    pieChart.itemsSource = pieData;
    pieChart.tooltip.isVisible = true;
    pieChart.tag = 1;
    snapshotButton.tag = 2;
    [self.view addSubview:snapshotButton];
    [self.view addSubview:pieChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexPie *pieChart= (FlexPie*)[self.view viewWithTag:1];
    UIButton *snapshotButton = (UIButton*)[self.view viewWithTag:2];
    pieChart.frame = CGRectMake(5, self.view.bounds.size.height/3, self.view.bounds.size.width-10, self.view.bounds.size.height/2);
    snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);
}
-(void)snapshotButtonClicked{
    FlexPie *pie = (FlexPie*)[self.view viewWithTag:1];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[pie getImage]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
}
-(void)imageSavedToPhotoAlbum:(UIImage *)image finishedSavingWithError: (NSError *)error contextInfo:(void *)contextInfo{
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"Success";
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
