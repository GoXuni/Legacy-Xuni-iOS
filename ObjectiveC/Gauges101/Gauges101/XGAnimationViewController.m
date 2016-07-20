//
//  XGAnimationViewController.m
//  Gauges101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "XGAnimationViewController.h"
@import XuniGaugeDynamicKit;

@interface XGAnimationViewController ()
@property (weak, nonatomic) IBOutlet XuniLinearGauge *linearGauge;
@property (weak, nonatomic) IBOutlet XuniRadialGauge *radialGauge;

@end

@implementation XGAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _radialGauge.loadAnimation.duration = 2;
    _radialGauge.updateAnimation.duration = 2.5;
    
    
    _linearGauge.loadAnimation.duration = 2;
    _linearGauge.updateAnimation.duration = 2.5;

    
    
    // Create ranges.
    XuniGaugeRange* lower = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    lower.min = 0;
    lower.max = 40;
    lower.color = [UIColor colorWithRed:0.133 green:0.694 blue:0.298 alpha:1];
    lower.borderColor = [UIColor whiteColor];
    lower.borderWidth = 1;
    XuniGaugeRange* middle = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    middle.min = 40;
    middle.max = 80;
    middle.color = [UIColor colorWithRed:1 green:0.502 blue:0.502 alpha:1];
    middle.borderColor = [UIColor whiteColor];
    middle.borderWidth = 1;
    XuniGaugeRange* upper = [[XuniGaugeRange alloc] initWithGauge:_linearGauge];
    upper.min = 80;
    upper.max = 100;
    upper.color = [UIColor colorWithRed:0 green:0.635 blue:0.91 alpha:1];
    upper.borderColor = [UIColor whiteColor];
    upper.borderWidth = 1;
    // Add ranges.
    [_linearGauge.ranges addObject:lower];
    [_linearGauge.ranges addObject:middle];
    [_linearGauge.ranges addObject:upper];
    [_radialGauge.ranges addObject:lower];
    [_radialGauge.ranges addObject:middle];
    [_radialGauge.ranges addObject:upper];
    
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animateNextStep:) userInfo:nil repeats:true];
}


-(void)animateNextStep:(id) sender{
    XuniLinearGauge *linearGauge = _linearGauge;
    XuniRadialGauge *radialGauge = _radialGauge;
    double random = (arc4random()% 101);
    linearGauge.updateAnimation.easing = [XuniEasing EaseOutBounce];
    radialGauge.updateAnimation.easing = [XuniEasing EaseOutBounce];
    linearGauge.value = random;
    radialGauge.value = random;
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
