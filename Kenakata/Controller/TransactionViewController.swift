//
//  TransactionViewController.swift
//  Kenakata
//
//  Created by Md Sifat on 25/12/20.
//  Copyright © 2020 Md Sifat. All rights reserved.
//

import UIKit
import Charts

class TransactionViewController: UIViewController {
    
    
    @IBOutlet weak var lchartView: BarChartView!
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let unitsSold = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    let unitsBought = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lchartView.delegate = self as? ChartViewDelegate
        lchartView.noDataText = "You need to provide data for the chart."
        // lchartView.chartDescription?.text = "sales vs bought "
        
        
        //legend
        let legend = lchartView.legend
        legend.enabled = false
        //                   legend.horizontalAlignment = .right
        //                   legend.verticalAlignment = .top
        //                   legend.orientation = .vertical
        //                   legend.drawInside = true
        //                   legend.yOffset = 10.0;
        //                   legend.xOffset = 10.0;
        //                   legend.yEntrySpace = 0.0;
        
        
        let xaxis = lchartView.xAxis
        // xaxis.valueFormatter = laxisFormatDelegate
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.months)
        xaxis.granularity = 1
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = lchartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        
        lchartView.rightAxis.enabled = false
        //axisFormatDelegate = self
        
        setChart()
        
        
    }
    
    
    func setChart() {
        lchartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.months.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: self.unitsSold[i])
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: self.self.unitsBought[i])
            dataEntries1.append(dataEntry1)
            
            //stack barchart
            //let dataEntry = BarChartDataEntry(x: Double(i), yValues:  [self.unitsSold[i],self.unitsBought[i]], label: "groupChart")
            
            
            
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1)
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDataSet.colors = ChartColorTemplates.colorful()
        //let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        
        
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = self.months.count
        let startYear = 0
        
        
        chartData.barWidth = barWidth;
        lchartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        lchartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        lchartView.notifyDataSetChanged()
        
        lchartView.data = chartData
        
        
        
        
        
        
        //background color
        lchartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        
        //chart animation
        lchartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        
        
    }
    
    
}
