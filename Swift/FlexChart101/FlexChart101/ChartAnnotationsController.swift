//
//  ChartAnnotationsController.swift
//  FlexChart101
//
//  Copyright (c) 2015 GrapeCity. All rights reserved.
//

import UIKit
import XuniFlexChartKit

class ChartAnnotationsController: UIViewController {

    var _chart = FlexChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Annotations"

        // Do any additional setup after loading the view.
        let sales = XuniSeries(forChart: _chart, binding: "sales, sales", name: "Sales")
        
        _chart.series.addObject(sales)
        _chart.itemsSource = ChartData.annotationData()
        _chart.bindingX = "name"
        _chart.chartType = XuniChartType.Line
        
        self.addAnnotations(_chart)
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

    func addAnnotations(chart: FlexChart) {
        // Polygon annotation.
        let polygon = XuniChartPolygonAnnotation(chart: chart)
        polygon.isVisible = true
        polygon.attachment = XuniChartAnnotationAttachment.Absolute
        polygon.color = UIColor.redColor()
        polygon.borderColor = UIColor(red: 20.0 / 255.0, green: 153.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
        polygon.borderWidth = 2
        polygon.textColor = UIColor.blackColor()
        polygon.text = "Absolute"
        polygon.tooltipText = "Polygon Annotation\nPaths:[{0,0},{40,40},{80,0},\n{60,-40},{20,-40}]\nAttachment:Absolute"
        
        let arr = NSMutableArray()
        arr.addObject(XuniPoint(x: 60, y: 40))
        arr.addObject(XuniPoint(x: 20, y: 80))
        arr.addObject(XuniPoint(x: 35, y: 120))
        arr.addObject(XuniPoint(x: 85, y: 120))
        arr.addObject(XuniPoint(x: 100, y: 80))
        polygon.points = arr
        
        // Ellipse annotation.
        let ellipse = XuniChartEllipseAnnotation(chart: chart)
        ellipse.isVisible = true
        ellipse.position = XuniChartAnnotationPosition.Center
        ellipse.attachment = XuniChartAnnotationAttachment.Relative
        ellipse.width = 60
        ellipse.height = 40
        ellipse.point = XuniPoint(x: 0.8, y: 0.3)
        ellipse.color = UIColor(red: 241.0 / 255.0, green: 175.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
        ellipse.borderColor = UIColor(red: 188.0 / 255.0, green: 136.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
        ellipse.borderWidth = 2
        ellipse.text = "Relative"
        ellipse.tooltipText = "Ellipse Annotation\nPoint:{0.8,0.3}\nAttachment:Relative"
        
        // Line annotation.
        let middleY = (chart.axisY.actualDataMax - chart.axisY.actualDataMin) / 2 + chart.axisY.actualDataMin
        let line = XuniChartLineAnnotation(chart: chart)
        line.isVisible = true
        line.attachment = XuniChartAnnotationAttachment.DataCoordinate
        line.start = XuniPoint(x: 0, y: middleY)
        line.end = XuniPoint(x: chart.axisX.actualDataMax, y: middleY)
        line.color = UIColor.blueColor()
        line.lineWidth = 3
        
        // Text annotation.
        let text = XuniChartTextAnnotation(chart: chart)
        text.isVisible = true
        text.position = XuniChartAnnotationPosition.Right
        text.attachment = XuniChartAnnotationAttachment.DataCoordinate
        text.width = 80
        text.height = 20
        text.point = XuniPoint(x: 0.3, y: middleY + 200)
        text.font = UIFont.boldSystemFontOfSize(12.0)
        text.text = "Data Coordinate"
        
        // Image annotation.
        let image = XuniChartImageAnnotation(chart: chart)
        image.isVisible = true
        image.position = XuniChartAnnotationPosition.Center
        image.attachment = XuniChartAnnotationAttachment.DataIndex
        image.seriesIndex = 0
        image.pointIndex = 2
        image.width = 50
        image.height = 50
        image.offset = XuniPoint(x: 0, y: 10)
        image.source = UIImage(named: "xuni_butterfly")
        image.tooltipText = "Image Annotation\nPointIndex:{2}\nAttachment:DataIndex"

        // Rectangle annotation.
        let rect = XuniChartRectangleAnnotation(chart: chart)
        rect.isVisible = true
        rect.position = XuniChartAnnotationPosition.Center
        rect.attachment = XuniChartAnnotationAttachment.DataIndex
        rect.seriesIndex = 0
        rect.pointIndex = 6
        rect.width = 100
        rect.height = 50
        rect.color = UIColor(red: 169.0 / 255.0, green: 230.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0)
        rect.borderColor = UIColor(red: 34.0 / 255.0, green: 166.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
        rect.borderWidth = 2
        rect.text = "DataIndex"
        rect.tooltipText = "Rectangle Annotation\nPointIndex:{6}\nAttachment:DataIndex"
        
        // Add annotations to chart.
        chart.annotations.addObject(polygon)
        chart.annotations.addObject(ellipse)
        chart.annotations.addObject(line)
        chart.annotations.addObject(text)
        chart.annotations.addObject(image)
        chart.annotations.addObject(rect)
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
