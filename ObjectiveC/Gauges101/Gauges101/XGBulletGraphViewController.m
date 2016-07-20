//
//  XGBulletGraphViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

@import XuniGaugeDynamicKit;

#import "XGBulletGraphViewController.h"


@interface XGBulletGraphViewController ()
@property (weak, nonatomic) IBOutlet UILabel *badDisplay;
@property (weak, nonatomic) IBOutlet UILabel *goodDisplay;
@property (weak, nonatomic) IBOutlet UILabel *targetDisplay;
@property (weak, nonatomic) IBOutlet UIStepper *badStepper;
@property (weak, nonatomic) IBOutlet UIStepper *goodStepper;
@property (weak, nonatomic) IBOutlet UIStepper *targetStepper;
@property (weak, nonatomic) IBOutlet XuniBulletGraph *bulletGraph;

@end

@implementation XGBulletGraphViewController

- (IBAction)stepperChanged:(id)sender {
    _bulletGraph.bad = _badStepper.value;
    _bulletGraph.good = _goodStepper.value;
    _bulletGraph.target = _targetStepper.value;
    
    _targetDisplay.text = [NSString stringWithFormat:@"%i", (int)_targetStepper.value];
    _badDisplay.text = [NSString stringWithFormat:@"%i", (int)_badStepper.value];
    _goodDisplay.text = [NSString stringWithFormat:@"%i", (int)_goodStepper.value];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _bulletGraph.loadAnimation.duration = 2;
    _bulletGraph.updateAnimation.duration = 0.5;
    
    
    [self stepperChanged:nil];
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
