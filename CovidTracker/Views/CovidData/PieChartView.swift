//
//  PieChartView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 20/12/20.
//

import SwiftUI

struct PieSliceView: Shape {
    
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

struct PieChartView: View {
    
    @EnvironmentObject var covidData: CovidDataViewModel
    @State var selectedPie: Int = -1
    @State var choosePie: Bool = false
    
    var body: some View {
        
        ZStack {
            ForEach(0..<covidData.countryData!.pieChart.pieSlices.count, content: { index in
                let pieSlice = covidData.countryData!.pieChart.pieSlices[index]
                
                ZStack {
                    PieSliceView(startAngle: pieSlice.startAngle, endAngle: pieSlice.endAngle)
                        .fill(pieSlice.color)
                        .shadow(radius: 15, x: 4, y: 4)
                        .scaleEffect(selectedPie == index ? 1.1 : 1)
                        .onTapGesture(count: 1) {
                            print("\(selectedPie)")
                            withAnimation {
                                if selectedPie == index {
                                    selectedPie = -1
                                } else {
                                    print("got here")
                                    selectedPie = index
                                }
                            }
                        }

                    GeometryReader { geoSize in
                        Text("\(pieSlice.percentage * 100, specifier: "%.1f")%")
                            .foregroundColor(pieSlice.color)
                            .position(getTextPosition(in: geoSize.size, angle: (pieSlice.startAngle + pieSlice.endAngle) / 2))
                            .scaleEffect(selectedPie == index ? 1.2 : 1)
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

//struct PieChartView_Previews: PreviewProvider {
//    static var previews: some View {
////        PieChartView()
//    }
//}
