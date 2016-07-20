//
//  RowDetailsViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

#import "CustomerData.h"
#import "XuniFlexGridDynamicKit/XuniFlexGridDynamicKit.h"
#import "RowDetailsViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RowDetailsViewController ()
@property (weak, nonatomic) IBOutlet FlexGrid           *grid;
@property (weak, nonatomic) IBOutlet UISegmentedControl *detailMode;

@end

@implementation RowDetailsViewController
- (IBAction)detailModeChange:(id)sender {
    switch (self.detailMode.selectedSegmentIndex) {
    case 0:
        self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityModeExpandSingle;
        break;
    case 1:
        self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityModeExpandMultiple;
        break;
    case 2:
        self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityModeSelection;
        break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.grid.isReadOnly    = true;
    self.grid.selectionMode = GridSelectionModeRow;
    self.grid.columnHeaderFont = [UIFont boldSystemFontOfSize:self.grid.columnHeaderFont.pointSize];
    self.grid.autoGenerateColumns = false;
 
    GridColumn *identifier = [[GridColumn alloc] init];
    identifier.binding    = @"customerID";
    identifier.header = @"ID";
    identifier.isReadOnly = true; 
    identifier.widthType  = GridColumnWidthPixel;
    identifier.width = 45;
    [self.grid.columns addObject:identifier];

    GridColumn *firstName = [[GridColumn alloc] init];
    firstName.binding   = @"firstName";
    firstName.widthType = GridColumnWidthStar;
    firstName.width     = 1;
    [self.grid.columns addObject:firstName];

    GridColumn *lastName = [[GridColumn alloc] init];
    lastName.binding   = @"lastName";
    lastName.widthType = GridColumnWidthStar;
    lastName.width     = 1;
    [self.grid.columns addObject:lastName];
    


    [self.grid.detailProvider.gridRowHeaderLoading addHandler:^(XuniEventContainer<GridRowHeaderLoadingEventArgs *> *eventContainer) {
        UIButton                          *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"show"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"hide"] forState:(UIControlStateSelected)];
        
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        eventContainer.eventArgs.button                  = btn;

    } forObject:self];

    
    [self.grid.detailProvider.detailCellCreating addHandler:^(XuniEventContainer<GridDetailCellCreatingEventArgs *> *eventContainer) {
        MKMapView *mapView = [[MKMapView alloc] init];
        eventContainer.eventArgs.view = mapView;
        mapView.userInteractionEnabled = false;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:((CustomerData*)eventContainer.eventArgs.row.dataItem).city completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            } else {
                CLPlacemark *placemark = [placemarks lastObject];
                float spanX = 0.0725;
                float spanY = 0.0725;
                MKCoordinateRegion region;
                region.center.latitude = placemark.location.coordinate.latitude;
                region.center.longitude = placemark.location.coordinate.longitude;
                region.span = MKCoordinateSpanMake(spanX, spanY);
                [mapView setRegion:region animated:NO];
            }
        }];

    } forObject:self];
 

    [self detailModeChange:self];

    self.grid.itemsSource = [CustomerData getCustomerData:100];

}


@end
