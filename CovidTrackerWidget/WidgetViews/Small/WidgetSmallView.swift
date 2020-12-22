//
//  WidgetView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI

struct WidgetSmallView: View {
    
    var entry: CovidTrackerEntry
    
    var body: some View {
        VStack {
            TitleView(date: entry.date)
            RowView(color: Color("TextNormal"), description: "confirmed", value: entry.countryData.confirmed.formatNumber())
            RowView(color: Color("TextActive"), description: "active", value: entry.countryData.active.formatNumber())
            RowView(color: Color("TextRecover"), description: "recover", value: entry.countryData.recovered.formatNumber())
            RowView(color: Color("TextDeath"), description: "death", value: entry.countryData.deaths.formatNumber())
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetSmallView(entry: CovidTrackerEntry.placeholder)
    }
}
