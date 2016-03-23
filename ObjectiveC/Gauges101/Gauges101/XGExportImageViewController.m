//
//  XGExportImageViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGExportImageViewController.h"
#import <XuniGaugeKit/XuniGaugeKit.h>

#define LOC(A) NSLocalizedString(A, nil)

@interface XGExportImageViewController ()
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;
@property (weak, nonatomic) IBOutlet UIImageView *snapshotDisplay;

@end

@implementation XGExportImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _radialGauge.showText = XuniShowTextNone;
    _radialGauge.thickness = 0.6;
    _radialGauge.min = 0;
    _radialGauge.max = 100;
    _radialGauge.value = 25;
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 2.5;
    _radialGauge.isReadOnly = true;
    _radialGauge.showText = XuniShowTextAll;

    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animateNextStep:) userInfo:nil repeats:true];
 
    _snapshotDisplay.hidden = true;
}

-(void)animateNextStep:(id) sender{
    XuniRadialGauge *radialGauge = _radialGauge;
    double random = (arc4random()% 101);
    radialGauge.updateAnimation.easing = [XuniEasing EaseOutElastic];
    radialGauge.value = random;
}


- (IBAction)saveSnapshot:(id)sender {
    if(_snapshotDisplay.hidden)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOC(@"Warning") message:LOC(@"You should take the snapshot before saving it to Camera Roll") delegate:nil cancelButtonTitle:LOC(@"OK")
                                              otherButtonTitles:nil];
        [alert show];

    }
    else
    {
        UIImageWriteToSavedPhotosAlbum(_snapshotDisplay.image, self, @selector(imageSavedToPhotoAlbum:finishedSavingWithError:contextInfo:), nil);
    }
}

-(void)imageSavedToPhotoAlbum:(UIImage *)image finishedSavingWithError: (NSError *)error contextInfo:(void *)contextInfo{
    NSString *message;
    NSString *title;
    if (!error) {
        title = LOC(@"Success");
        message = LOC(@"Image was saved to Camera Roll succesfully");
    }
    else{
        title = LOC(@"Failure");
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:LOC(@"OK") otherButtonTitles:nil];
    [alert show];
}

- (IBAction)takeSnapshot:(id)sender {
    UIImage *image = [[UIImage alloc] init];
    image = [UIImage imageWithData:[_radialGauge getImage]];
    [_snapshotDisplay setImage:image];
    _radialGauge.hidden = true;
    _snapshotDisplay.hidden = false;
    _snapshotDisplay.layer.borderWidth = 10;
    _snapshotDisplay.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
