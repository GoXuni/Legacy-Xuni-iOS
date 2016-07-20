//
//  RowDetailsViewController.h
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//
import UIKit
import XuniFlexGridDynamicKit

class RowDetailsViewController: UIViewController {

    @IBAction func detailModeChange(sender: AnyObject) {
        switch self.detailMode.selectedSegmentIndex {
            case 0:
                self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityMode.ExpandSingle
            case 1:
                self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityMode.ExpandMultiple
            case 2:
                self.grid.detailProvider.detailVisibilityMode = GridDetailVisibilityMode.Selection
        default:
            self.grid.detailProvider.detailVisibilityMode = .None
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.grid.isReadOnly = true
        self.grid.selectionMode = GridSelectionMode.Row
        self.grid.columnHeaderFont = UIFont.boldSystemFontOfSize(self.grid.columnHeaderFont.pointSize)
        self.grid.autoGenerateColumns = false
        
        let identifier: GridColumn = GridColumn()
        identifier.binding = "customerID"
        identifier.header = "ID"
        identifier.isReadOnly = true
        identifier.widthType = GridColumnWidth.Pixel
        identifier.width = 45
        self.grid.columns.addObject(identifier)
        let firstName: GridColumn = GridColumn()
        firstName.binding = "firstName"
        firstName.widthType = GridColumnWidth.Star
        firstName.width = 1
        self.grid.columns.addObject(firstName)
        let lastName: GridColumn = GridColumn()
        lastName.binding = "lastName"
        lastName.widthType = GridColumnWidth.Star
        lastName.width = 1
        self.grid.columns.addObject(lastName)
        
        self.grid.detailProvider.gridRowHeaderLoading.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridRowHeaderLoadingEventArgs
            let btn: UIButton = UIButton(type: .Custom)
            btn.setImage(UIImage(named: "show"), forState: (.Normal))
            btn.setImage(UIImage(named: "hide"), forState: (.Selected))
            btn.imageView!.contentMode = .ScaleAspectFit
            eventContainerEventArgs.button = btn
        }, forObject: self)
        
        self.grid.detailProvider.detailCellCreating.addHandler({(eventContainer: XuniEventContainer!) -> Void in
            let eventContainerEventArgs = eventContainer.eventArgs as! GridDetailCellCreatingEventArgs
            let mapView: MKMapView = MKMapView()
            eventContainerEventArgs.view = mapView
            mapView.userInteractionEnabled = false
            let geocoder: CLGeocoder = CLGeocoder()
            geocoder.geocodeAddressString((eventContainerEventArgs.row.dataItem as! CustomerData).city, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                if error != nil {
                    print("\(error)")
                }
                else {
                    let placemark: CLPlacemark = placemarks!.last!
                    let spanX: Double = 0.0725
                    let spanY: Double = 0.0725
                    var region: MKCoordinateRegion =  MKCoordinateRegion()
                    region.center.latitude = placemark.location!.coordinate.latitude
                    region.center.longitude = placemark.location!.coordinate.longitude
                    region.span = MKCoordinateSpanMake(spanX, spanY)
                    mapView.setRegion(region, animated: false)
                }
            })
        }, forObject: self)
        self.detailModeChange(self)
        self.grid.itemsSource = NSMutableArray(array:CustomerData.getCustomerData(100))
    }

    @IBOutlet weak var grid: FlexGrid!
    @IBOutlet weak var detailMode: UISegmentedControl!
}
//
//  RowDetailsViewController.m
//  FlexGrid101
//
//  Copyright © 2016 GrapeCity. All rights reserved.
//

import MapKit
import CoreLocation