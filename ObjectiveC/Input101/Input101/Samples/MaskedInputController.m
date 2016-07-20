//
//  MaskedInputController.m
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "MaskedInputController.h"
@import XuniInputDynamicKit;

@interface MaskedInputController ()

@property (weak, nonatomic) IBOutlet XuniMaskedTextField *maskedID;
@property (weak, nonatomic) IBOutlet XuniMaskedTextField *maskedDOB;
@property (weak, nonatomic) IBOutlet XuniMaskedTextField *maskedPhone;
@property (weak, nonatomic) IBOutlet XuniMaskedTextField *maskedState;

@end

@implementation MaskedInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.maskedID.mask = @"000-00-0000";
    self.maskedDOB.mask = @"90/90/0000";
    self.maskedPhone.mask = @"(999) 000-0000";
    self.maskedState.mask = @"LL";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
