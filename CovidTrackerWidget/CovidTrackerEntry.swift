//
//  CovidTrackerEntry.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//
import WidgetKit
import Foundation
import Intents

struct CovidTrackerEntry: TimelineEntry {
    var date: Date
    let countryData: CountryDataModel
    var isPlaceholder: Bool = false
    
    // MARK: Stub and Placeholder
    static var stub: CovidTrackerEntry {
        return CovidTrackerEntry(date: Date(), countryData: CountryDataModel(recovered: 100, deaths: 5, confirmed: 1000))
    }
    
    static var placeholder: CovidTrackerEntry {
        return CovidTrackerEntry(date: Date(), countryData: CountryDataModel(recovered: 0, deaths: 0, confirmed: 0))
    }
}
