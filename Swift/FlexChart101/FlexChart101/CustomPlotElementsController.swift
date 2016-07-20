//
//  CustomPlotElementsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class CustomPlotElementsController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Custom Plot Elements", comment: "")
        
        // Do any additional setup after loading the view.
        let devicesSold = XuniSeries(forChart: _chart, binding: "devicesSold", name: "Devices sold")
        
        _chart.series.addObject(devicesSold)
        _chart.bindingX = "name"
        _chart.itemsSource = CustomPoint.getList()
        _chart.isAnimated = false
        _chart.legend.position = XuniChartLegendPosition.None
        _chart.axisY.axisLineVisible = false
        _chart.axisY.majorTickWidth = 0
        _chart.axisY.title = "Devices Sold (billions)"
        _chart.axisY.titleFont = UIFont.italicSystemFontOfSize(16.0)
        _chart.axisX.majorTickWidth = 0
        _chart.axisX.minorTickWidth = 1
        
        func plotElementLoadingHandler(args: XuniEventContainer!) {
            let plotArgs = args.eventArgs as! XuniChartPlotElementEventArgs
            if plotArgs.renderEngine != nil && plotArgs.hitTestInfo != nil && plotArgs.defaultRender != nil {
                (plotArgs.renderEngine as! XuniRenderEngine).setFill(UIColor.grayColor())
                plotArgs.defaultRender.execute()
                
                var rect = (plotArgs.defaultRender as! DefaultBarElementRender).getBarRect()
                let customPoint: CustomPoint = _chart.itemsSource.objectAtIndex(Int(plotArgs.dataPoint.pointIndex)) as! CustomPoint
                rect.origin.y += (rect.size.height - rect.size.width) / 2;
                rect.size.height = rect.size.width;
                customPoint.logo.drawInRect(rect)
            }
        }
        _chart.plotElementLoading.addHandler(plotElementLoadingHandler, forObject: self)

        
        self.view.addSubview(_chart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height - 65)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class CustomPoint : NSObject {
    var name: String
    var devicesSold: Int
    var logo: UIImage
    
    init(name: String, devicesSold: Int, logo: UIImage) {
        self.name = name
        self.devicesSold = devicesSold
        self.logo = logo
    }
    
    class func getList() -> NSMutableArray {
        var n = 3
        var nameList = ["Apple", "Google", "Microsoft"]
        var list = NSMutableArray()
        
        for var i = 0; i < n; i++ {
            var imageName = nameList[i]
            list.addObject(CustomPoint(name: imageName, devicesSold: Int((arc4random() % 10 + 10)), logo: UIImage(named:imageName.lowercaseString)!))
        }
        
        return list
    }
}

