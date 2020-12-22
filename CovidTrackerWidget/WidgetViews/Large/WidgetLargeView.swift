//
//  WidgetLargeView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI

struct WidgetLargeView: View {
    
    var entry: CovidTrackerEntry
    
    var body: some View {
        VStack {
            HStack {
                Text("🇦🇺").font(.system(size: 24, weight: .semibold))
                Text(entry.date, style: .time).font(.system(size: 20, weight: .semibold))
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            
            WidgetPieChartView(entry: entry)
            
            HStack(spacing: 0) {
                WidgetTileView(color: Color("TextNormal"), description: "confirmed", value: entry.countryData.confirmed.formatNumber())
                WidgetTileView(color: Color("TextActive"), description: "active", value: entry.countryData.active.formatNumber())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
            HStack(spacing: 0) {
                WidgetTileView(color: Color("TextRecover"), description: "recovered", value: entry.countryData.recovered.formatNumber())
                WidgetTileView(color: Color("TextDeath"), description: "death", value: entry.countryData.deaths.formatNumber())
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        
//        Text("haha")
    }
}

struct WidgetLargeView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetLargeView(entry: CovidTrackerEntry.placeholder)
    }
}
