//
//  CustomTooltipsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit
import XuniChartCoreKit
import XuniCoreKit

class CustomTooltipsController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Custom Tooltips", comment: "")
        
        // Do any additional setup after loading the view.
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        
        _chart.itemsSource = ChartData.demoData()
        _chart.bindingX = "name"
        _chart.stacking = XuniStacking.Stacked
        _chart.palette = XuniPalettes.zen()
        _chart.loadAnimation.animationMode = XuniAnimationMode.Series
        _chart.axisY.axisLineVisible = false
        _chart.axisY.majorUnit = 2000

        let t = MyTooltip()
        t.backgroundColor = UIColor(red: 1, green: 1, blue: 0.792, alpha: 1)
        _chart.tooltip.content = t
        //_chart.tooltip.backgroundColor = UIColor(red: 1, green: 1, blue: 0.792, alpha: 1)
        
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

class MyTooltip : XuniBaseChartTooltipView {
    
    var label = UILabel()
    var image = UIImage()
    var imageView = UIImageView()
    var tooltipWidth = CGFloat()
    var tooltipHeight = CGFloat()
    
    override var chartData : XuniDataPoint? {
        get{
            return self.chartData
        }
        
        set{
            var cdpt: XuniChartDataPoint = newValue as! XuniChartDataPoint
            
            if (imageView.image == nil) {
                label = UILabel()
                label.frame = CGRectMake(self.bounds.size.width/4, 0, self.bounds.size.width*3/4, self.bounds.size.height)
                label.textColor = UIColor.blackColor()
                label.numberOfLines = 3
                label.text = "\(cdpt.seriesName) \n\n $\(cdpt.value)"
                label.font = label.font.fontWithSize(11)
                image = UIImage(named:"\(cdpt.pointIndex)")!
                imageView =  UIImageView(image: image)
                self.addSubview(imageView)
                self.addSubview(label)
            }
            else{
                image = UIImage(named:"\(cdpt.pointIndex)")!
                imageView.image = image
                label.text = "\(cdpt.seriesName) \n\n $\(cdpt.value)"
                imageView.setNeedsLayout()
            }
        }
    }
    
    func _render() {
        //prevents drawing of default tooltip
    }
    
    //these two methods draw the tooltip frames... the conditional logic checks screen bounds
    func _getFrameRect(contentFrame: CGRect, senderPoint:CGPoint)->(CGRect) {
        tooltipHeight = 50
        tooltipWidth = 100
        
        if ((UIScreen.mainScreen().bounds.width - senderPoint.x) < tooltipWidth  && (UIScreen.mainScreen().bounds.height - senderPoint.y) < tooltipHeight){
            return CGRectMake((UIScreen.mainScreen().bounds.width - tooltipWidth), (UIScreen.mainScreen().bounds.height - tooltipHeight), tooltipWidth, tooltipHeight)
        }
        else if ((UIScreen.mainScreen().bounds.width - senderPoint.x) < tooltipWidth){
            return CGRectMake((UIScreen.mainScreen().bounds.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight)
        }
        else if ((UIScreen.mainScreen().bounds.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(senderPoint.x, (UIScreen.mainScreen().bounds.height - tooltipHeight), tooltipWidth, tooltipHeight)
        }
        else{
            return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight)
        }
    }
    
    func _getContentFrameRect(contentFrame: CGRect, senderPoint:CGPoint)->(CGRect) {
        tooltipHeight = 50
        tooltipWidth = 100
        
        if ((UIScreen.mainScreen().bounds.width - senderPoint.x) < tooltipWidth  && (UIScreen.mainScreen().bounds.height - senderPoint.y) < tooltipHeight){
            return CGRectMake((UIScreen.mainScreen().bounds.width - tooltipWidth), (UIScreen.mainScreen().bounds.height - tooltipHeight), tooltipWidth, tooltipHeight)
        }
        else if ((UIScreen.mainScreen().bounds.width - senderPoint.x) < tooltipWidth){
            return CGRectMake((UIScreen.mainScreen().bounds.width - tooltipWidth), senderPoint.y, tooltipWidth, tooltipHeight)
        }
        else if ((UIScreen.mainScreen().bounds.height - senderPoint.y) < tooltipHeight){
            return CGRectMake(senderPoint.x, (UIScreen.mainScreen().bounds.height - tooltipHeight), tooltipWidth, tooltipHeight)
        }
        else{
            return CGRectMake(senderPoint.x, senderPoint.y, tooltipWidth, tooltipHeight)
        }
    }
}