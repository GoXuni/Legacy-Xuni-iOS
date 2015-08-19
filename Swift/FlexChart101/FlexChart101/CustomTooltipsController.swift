//
//  CustomTooltipsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexChartKit
import XuniChartCoreKit
import XuniCoreKit

class CustomTooltipsController: UIViewController {
    
    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        _chart.bindingX = "name"
        
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        let expenses = XuniSeries(forChart: _chart, binding: "expenses, expenses", name: "Expenses")
        let downloads = XuniSeries(forChart: _chart, binding: "downloads, downloads", name: "Downloads")
        
        _chart.series.addObject(sales)
        _chart.series.addObject(expenses)
        _chart.series.addObject(downloads)
        _chart.tooltip.backgroundColor = UIColor(red: 1, green: 1, blue: 0.792, alpha: 1)
        _chart.itemsSource = ChartData.demoData()

        let t = MyTooltip()
        t.backgroundColor = UIColor(red: 1, green: 1, blue: 0.792, alpha: 1)
        _chart.tooltip.content = t;
        
        _chart.legend.orientation = XuniChartLegendOrientation.Auto
        _chart.legend.position = XuniChartLegendPosition.Auto
        _chart.tooltip.visible = true
        _chart.axisX.labelsVisible = true
        _chart.axisY.labelsVisible = true
        
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
    
    override var chartData : XuniDataPoint?{
        get{
            return self.chartData
        }
        
        set{

            if (imageView.image == nil) {
                label = UILabel()
                label.frame = CGRectMake(self.bounds.size.width/4, 0, self.bounds.size.width*3/4, self.bounds.size.height)
                label.textColor = UIColor.blackColor()
                label.numberOfLines = 3
                label.text = "\(newValue!.seriesName)\n\(newValue!.dataX)\n\(newValue!.dataY)"
                label.font = label.font.fontWithSize(11)
                image = UIImage(named:"\(newValue!.dataX)")!
                imageView =  UIImageView(image: image)
                self.addSubview(imageView)
                self.addSubview(label)
            }
            else{
                image = UIImage(named:"\(newValue!.dataX)")!
                imageView.image = image
                label.text = "\(newValue!.seriesName)\n\(newValue!.dataX)\n\(newValue!.dataY)"
                imageView.setNeedsLayout()
            }
        }
    }
    func _render(){
        //prevents drawing of default tooltip
    }
    
    //these two methods draw the tooltip frames... the conditional logic checks screen bounds
    func _getFrameRect(contentFrame: CGRect, senderPoint:CGPoint)->(CGRect){
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
    func _getContentFrameRect(contentFrame: CGRect, senderPoint:CGPoint)->(CGRect){
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