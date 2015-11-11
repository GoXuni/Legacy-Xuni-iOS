//
//  FilterController.m
//  FlexGrid101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

#import "FilterController.h"
#import "CustomerData.h"
#import "XuniFlexGridKit/XuniFlexGridKit.h"
#import "FilterFormController.h"
#import "SharedFilterData.h"

@interface FilterController (){
    SharedFilterData *sharedData;
}

@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sharedData = [SharedFilterData sharedInstance];
    UIButton *filterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    FlexGrid *flex = [[FlexGrid alloc] init];
    flex.isReadOnly = true;
    flex.itemsSource = [CustomerData getCustomerData:100];
    [filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    [removeButton setTitle:@"Remove" forState:UIControlStateNormal];
    [filterButton addTarget:self action:@selector(filterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [removeButton addTarget:self action:@selector(removeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    flex.tag = 1;
    filterButton.tag = 2;
    removeButton.tag = 3;
    
    [self.view addSubview:filterButton];
    [self.view addSubview:removeButton];
    [self.view addSubview:flex];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:true];
    
    if (sharedData.filterSet == true) {
        
        if (sharedData.filterOperation == 0) {
            [self containsFilter];
        }
        else if ([sharedData.filterOperation  isEqual: @(1)]){
            [self beginsWithFilter];
        }
        else if ([sharedData.filterOperation isEqual: @(2)]){
            [self endsWithFilter];
        }
        else if ([sharedData.filterOperation isEqual: @(3)]){
            [self equalsFilter];
        }
    }
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:true];
    sharedData.filterSet = false;
    sharedData.filterString = @"";
    sharedData.filterOperation = 0;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    FlexGrid *flex = (FlexGrid*)[self.view viewWithTag:1];
    UIButton *filterButton = (UIButton*)[self.view viewWithTag:2];
    UIButton *removeButton = (UIButton*)[self.view viewWithTag:3];
    filterButton.frame = CGRectMake(0, 60, self.view.bounds.size.width/2, 50);
    
    removeButton.frame = CGRectMake(self.view.bounds.size.width/2, 60, self.view.bounds.size.width/2, 50);
    
    flex.frame = CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-110);
}

-(void)filterButtonClicked{
    [self performSegueWithIdentifier:@"FilterFormSegue" sender:self];
}
-(void)containsFilter{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        CustomerData *d = (CustomerData*)item;
        if ([[NSString stringWithFormat:@"%lu", d.customerID] rangeOfString:sharedData.filterString].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%lu", d.countryID]  rangeOfString:sharedData.filterString].location != NSNotFound) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@",d.email] rangeOfString:sharedData.filterString].location != NSNotFound) {
            return true;
        }
        else if ([[d.firstName lowercaseString] rangeOfString:[sharedData.filterString lowercaseString]].location != NSNotFound) {
            return true;
        }
        else if ([[d.lastName lowercaseString] rangeOfString:[sharedData.filterString lowercaseString]].location != NSNotFound)
        {
            return true;
        }
        else if ([[d.country lowercaseString] rangeOfString:[sharedData.filterString lowercaseString]].location != NSNotFound){
            return true;
        }
        else if ([[d.address lowercaseString] rangeOfString:[sharedData.filterString lowercaseString]].location != NSNotFound){
            return true;
        }
        else if ([[d.city lowercaseString] rangeOfString:[sharedData.filterString lowercaseString]].location != NSNotFound){
            return true;
        }
        else if ([[dateFormat stringFromDate:d.lastOrderDate] rangeOfString:sharedData.filterString].location != NSNotFound) {
            return true;
        }
        else {
            return false;
        }
    };

}

-(void)equalsFilter{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        CustomerData *d = (CustomerData*)item;
        
        if ([[NSString stringWithFormat:@"%lu", d.customerID] isEqualToString:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%lu", d.countryID] isEqualToString:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@", d.email] isEqualToString:sharedData.filterString]) {
            return true;
        }
        else if ([d.firstName isEqualToString:sharedData.filterString]) {
            return true;
        }
        else if ([d.lastName isEqualToString:sharedData.filterString])
        {
            return true;
        }
        else if ([d.country isEqualToString:sharedData.filterString]){
            return true;
        }
        else if ([d.address isEqualToString:sharedData.filterString]){
            return true;
        }
        else if ([d.city isEqualToString:sharedData.filterString]){
            return true;
        }
        else if ([[dateFormat stringFromDate:d.lastOrderDate] isEqualToString:sharedData.filterString]) {
            return true;
        }
        else {
            return false;
        }
    };
}

-(void)beginsWithFilter{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        CustomerData *d = (CustomerData*)item;
        if ([[NSString stringWithFormat:@"%lu", d.customerID] hasPrefix:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%lu", d.countryID]  hasPrefix:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@",d.email] hasPrefix:sharedData.filterString]) {
            return true;
        }
            
        else if ([[d.firstName lowercaseString] hasPrefix:[sharedData.filterString lowercaseString]]) {
            return true;
        }
        else if ([[d.lastName lowercaseString] hasPrefix:[sharedData.filterString lowercaseString]])
        {
            return true;
        }
        else if ([[d.country lowercaseString] hasPrefix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[d.address lowercaseString] hasPrefix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[d.city lowercaseString] hasPrefix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[dateFormat stringFromDate:d.lastOrderDate] hasPrefix:sharedData.filterString]) {
            return true;
        }
        else {
            return false;
        }
    };
}

-(void)endsWithFilter{
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"M/d/yy"];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        CustomerData *d = (CustomerData*)item;
        if ([[NSString stringWithFormat:@"%lu", d.customerID] hasSuffix:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%lu", d.countryID]  hasSuffix:sharedData.filterString]) {
            return true;
        }
        else if ([[NSString stringWithFormat:@"%@",d.email] hasSuffix:sharedData.filterString]) {
            return true;
        }
        
        else if ([[d.firstName lowercaseString] hasSuffix:[sharedData.filterString lowercaseString]]) {
            return true;
        }
        else if ([[d.lastName lowercaseString] hasSuffix:[sharedData.filterString lowercaseString]])
        {
            return true;
        }
        else if ([[d.country lowercaseString] hasSuffix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[d.address lowercaseString] hasSuffix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[d.city lowercaseString] hasSuffix:[sharedData.filterString lowercaseString]]){
            return true;
        }
        else if ([[dateFormat stringFromDate:d.lastOrderDate] hasSuffix:sharedData.filterString]) {
            return true;
        }
        else {
            return false;
        }
    };
}

-(void)removeButtonClicked{
    sharedData.filterSet = false;
    sharedData.filterString = @"";
    sharedData.filterOperation = 0;
    FlexGrid *flex =  (FlexGrid *)[self.view viewWithTag:1];
    flex.collectionView.filter = ^ BOOL (NSObject *item){
        return true;
    };
}
@end