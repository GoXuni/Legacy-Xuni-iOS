//
//  CustomizingAxesController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class CustomizingAxesController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Customizing Axes", comment: "")
        
        // Do any additional setup after loading the view.
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.axisX.title = "Country"
        _chart.axisX.lineWidth = 2
        _chart.axisX.minorTickWidth = 1
        _chart.axisX.majorTickWidth = 0
        
        _chart.axisY.lineWidth = 2
        _chart.axisY.minorGridVisible = true
        _chart.axisY.minorGridWidth = 0.5
        _chart.axisY.minorGridDashes = NSArray(array: [4, 4]) as! [NSNumber]
        _chart.axisY.minorTickWidth = 1
        _chart.axisY.majorTickWidth = 2
        _chart.axisY.majorGridWidth = 1
        
        _chart.axisY.majorGridColor = UIColor(white: 0.8, alpha: 1)
        _chart.axisY.majorGridFill = UIColor(white: 0.6, alpha: 0.2)
        _chart.axisY.axisLineVisible = true
        _chart.axisY.majorUnit = 1000
        _chart.axisY.max = 10000
        
        func axisXLabelLoadingHandler(args: XuniEventContainer!) {
            let labelArgs = args.eventArgs as! XuniLabelLoadingEventArgs
            labelArgs.label = nil
            
            let image = UIImage(named:"\(labelArgs.value)")!
            let rect = CGRectMake (CGFloat(labelArgs.region.left), CGFloat(labelArgs.region.top), CGFloat(labelArgs.region.width), CGFloat(labelArgs.region.height))
            image.drawInRect(rect)
        }
        _chart.axisX.labelLoading.addHandler(axisXLabelLoadingHandler, forObject: self)
        
        func axisYLabelLoadingHandler(args: XuniEventContainer!) {
            let labelArgs = args.eventArgs as! XuniLabelLoadingEventArgs
            let renderEngine = labelArgs.renderEngine as! XuniRenderEngine
            
            if (labelArgs.value <= 3000) {
                renderEngine.setTextFill(UIColor.redColor())
            }
            else if (labelArgs.value <= 10000 && labelArgs.value > 6000) {
                renderEngine.setTextFill(UIColor.greenColor())
            }
            else {
                renderEngine.setTextFill(UIColor.blackColor())
            }
            labelArgs.label = String(format: "$%.0fK", (labelArgs.value / 1000))
            
        };
        _chart.axisY.labelLoading.addHandler(axisYLabelLoadingHandler, forObject:self)
        
        self.view.addSubview(_chart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chart.frame = CGRectMake(0, 55, self.view.bounds.size.width, self.view.bounds.size.height - 55)
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
