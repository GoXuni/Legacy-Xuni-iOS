//
//  SnapshotController.m
//  Gauges101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "SnapshotController.h"
#import "XuniGaugeKit/XuniGaugeKit.h"
@interface SnapshotController ()

@end

@implementation SnapshotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XuniRadialGauge *radialGauge;

    double min;
    double max;
    double val;
    
    min = 0;
    max = 100;
    val = 25;
    
    
    UIButton *snapshotButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageView *snapshotImage = [[UIImageView alloc] init];
    snapshotImage.tag = 2;
    snapshotButton.tag = 3;
    [snapshotButton setTitle:@"Take a snapshot" forState:UIControlStateNormal];
    [snapshotButton addTarget:self action:@selector(snapshotButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    radialGauge = [[XuniRadialGauge alloc] init];
    radialGauge.tag = 1;
    radialGauge.showText = XuniShowTextAll;
    radialGauge.thickness = 0.6;
    radialGauge.min = min;
    radialGauge.max = max;
    radialGauge.value = val;
    radialGauge.loadAnimation.duration = 2;
    radialGauge.updateAnimation.duration = 2;
    radialGauge.pointer.thickness = .5;
    [self.view addSubview:snapshotImage];
    [self.view addSubview:radialGauge];
    [self.view addSubview:snapshotButton];
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(animateNextStep:) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)animateNextStep:(id) sender{
    XuniRadialGauge *radialGauge = (XuniRadialGauge*) [self.view viewWithTag:1];
    double random = (arc4random()% 101);
    radialGauge.value = random;
}
-(void)snapshotButtonClicked{
    XuniRadialGauge *radialGauge = (XuniRadialGauge*)[self.view viewWithTag:1];
    UIImageView *iv = (UIImageView*)[self.view viewWithTag:2];
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[radialGauge getImage]];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
    [iv setImage:image];
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

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    XuniRadialGauge *radialGauge = (XuniRadialGauge*)[self.view viewWithTag:1];
    UIImageView *snapshotImage = (UIImageView *)[self.view viewWithTag:2];
    UIButton *snapshotButton = (UIButton*)[self.view viewWithTag:3];
    
    radialGauge.frame = CGRectMake(5, 115, self.view.bounds.size.width-10, self.view.bounds.size.height/2 - 65);
    XuniRect *r = [[XuniRect alloc] initLeft:5 top:115 width:(self.view.bounds.size.width - 10) height:(self.view.bounds.size.height/2 - 65)];
    radialGauge.rectGauge = r;
    [radialGauge setNeedsDisplay];
    
    snapshotImage.frame = CGRectMake(5, self.view.bounds.size.height / 2 + 65, self.view.bounds.size.width - 10, self.view.bounds.size.height/2 - 65);
    [snapshotImage setNeedsDisplay];
    
    snapshotButton.frame = CGRectMake(0, 65, self.view.bounds.size.width, 50);
    [snapshotButton setNeedsDisplay];
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
