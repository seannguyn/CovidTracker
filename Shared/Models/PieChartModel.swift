//
//  PieChartModel.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 20/12/20.
//

import Foundation
import SwiftUI

struct PieChartModel {
    
    var pieSlices: [PieSliceModel]
    
    init(data: [Int64], labels: [String], colors: [Color]) {
        
        pieSlices = []
        
        let sum = data.reduce(0, +)
        var tempStartAngle: Double = 0
        
        for (index, value) in data.enumerated() {
            
            let percentage = Double(value) / Double(sum)
            let startAngle = tempStartAngle
            let endAngle = tempStartAngle + percentage * 360
            
            pieSlices.append(PieSliceModel(label: labels[index], percentage: percentage, startAngle: startAngle, endAngle: endAngle, color: colors[index]))
            
            tempStartAngle = endAngle
        }
    }
}

struct PieSliceModel: Identifiable {
    let id = UUID()
    let label: String
    let percentage: Double
    let startAngle: Double
    let endAngle: Double
    let color: Color
}
