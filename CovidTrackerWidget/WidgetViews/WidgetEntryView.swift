//
//  WidgetEntryView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI

struct WidgetEntryView: View {
    var entry: CovidTrackerEntry
        @Environment(\.widgetFamily) var family
        
        var body: some View {
            switch family {
            case .systemSmall:
                WidgetSmallView(entry: entry)
            case .systemLarge:
                WidgetLargeView(entry: entry)
            default:
                WidgetSmallView(entry: entry)
            }
        }
}

struct WidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetEntryView(entry: CovidTrackerEntry.placeholder)
    }
}
