//
//  WidgetPieChartView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI

struct WidgetPieChartView: View {
    
    var entry: CovidTrackerEntry
    
    var body: some View {
        
        ZStack {
            ForEach(0..<entry.countryData.pieChart.pieSlices.count, content: { index in
                let pieSlice = entry.countryData.pieChart.pieSlices[index]
                
                ZStack {
                    WidgetPieSliceView(startAngle: pieSlice.startAngle, endAngle: pieSlice.endAngle)
                        .fill(pieSlice.color)
                        .shadow(radius: 15, x: 4, y: 4)

                    GeometryReader { geoSize in
                        Text("\(pieSlice.percentage * 100, specifier: "%.1f")%")
                            .foregroundColor(pieSlice.color)
                            .position(getTextPosition(in: geoSize.size, angle: (pieSlice.startAngle + pieSlice.endAngle) / 2))
                    }
                }

            })

        }
            .frame(height: 200)
        .padding([.vertical], 15)
    }
    
    func getTextPosition(in geoSize: CGSize, angle: Double) -> CGPoint {
        
        let centerPoint = CGPoint(x: geoSize.width/2, y: geoSize.height/2)
        
        let radius = min(geoSize.width, geoSize.height) / 2
        
        let x = radius * cos(CGFloat(angle) * (CGFloat.pi / 180))
        let y = radius * sin(CGFloat(angle) * (CGFloat.pi / 180))
        
        return CGPoint(x: centerPoint.x + x*1.25, y: centerPoint.y + y)
    }
}

struct WidgetPieSliceView: Shape {
    
    var startAngle: Double
    var endAngle: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: centerPoint)
        path.addArc(center: centerPoint, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: endAngle), clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct WidgetPieChartView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetPieChartView(entry: CovidTrackerEntry.placeholder)
    }
}
