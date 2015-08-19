//
//  GettingStartedController.swift
//  FlexPie101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import FlexPieKit

class GettingStartedController: UIViewController {
    
    var _pieChart = FlexPie()
    var _donutChart = FlexPie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        // Do any additional setup after loading the view.
        var pieData = NSMutableArray()
        pieData = PieChartData.demoData()
        _pieChart.binding = "value"
        _pieChart.bindingName = "name"
        _pieChart.itemsSource = pieData
        _pieChart.tooltip.visible = true
        _donutChart.binding = "value"
        _donutChart.bindingName = "name"
        _donutChart.itemsSource = pieData
        _donutChart.tooltip.visible = true
        _donutChart.innerRadius = 0.6
        self.view.addSubview(_pieChart)
        self.view.addSubview(_donutChart)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        _pieChart.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/3)
        _donutChart.frame = CGRectMake(0, self.view.bounds.size.height/2, self.view.bounds.size.width, self.view.bounds.size.height/3)
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
