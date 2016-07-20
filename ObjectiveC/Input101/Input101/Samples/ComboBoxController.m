//
//  ComboBoxController.m
//  Input101
//
//  Copyright (c) GrapeCity, Inc. All rights reserved.
//

#import "ComboBoxController.h"
@import XuniInputDynamicKit;
#import "AutoCompleteData.h"

@interface ComboBoxController ()<XuniComboBoxDelegate, XuniDropDownDelegate>

@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxEdit;
@property (weak, nonatomic) IBOutlet XuniComboBox *comboBoxNonEdit;

@end

@implementation ComboBoxController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.comboBoxEdit.delegate = self;
    self.comboBoxEdit.displayMemberPath = @"name";
    self.comboBoxEdit.itemsSource = [AutoCompleteData demoData];;
    self.comboBoxEdit.dropDownHeight = 200;
    self.comboBoxEdit.placeholder = @"Please Enter...";
    
    self.comboBoxNonEdit.delegate = self;
    self.comboBoxNonEdit.displayMemberPath = @"name";
    self.comboBoxNonEdit.itemsSource = [AutoCompleteData demoData];;
    self.comboBoxNonEdit.isEditable = NO;
    self.comboBoxNonEdit.dropDownBehavior = XuniDropDownBehaviorHeaderTap;
    self.comboBoxNonEdit.dropDownHeight = 200;
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


