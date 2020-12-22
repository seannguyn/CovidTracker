//
//  CovidTrackerWidget.swift
//  CovidTrackerWidget
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import WidgetKit
import SwiftUI
import Intents

// MARK: Widget Main
//@main
struct CovidTrackerWidget: Widget {
    let kind: String = "au.com.centennialcoal.sean.s.nguyen.CovidTracker"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CovidTrackerProvider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemLarge])
        .configurationDisplayName("Covid Tracker Widget")
        .description("Display latest covid-19 statistic")
    }
}

struct CovidTrackerWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: CovidTrackerEntry.placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

