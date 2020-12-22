//
//  CovidTrackerProvider.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//
import WidgetKit
import Foundation
import Intents

struct CovidTrackerProvider: TimelineProvider {
    
    typealias Entry = CovidTrackerEntry
    
    let covidAPIService = CovidAPIService.shared
    
    func placeholder(in context: Context) -> CovidTrackerEntry {
        return CovidTrackerEntry.placeholder
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CovidTrackerEntry>) -> Void) {
        fetchCovidAPI(completion: { entry in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        })
    }

    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        if context.isPreview {
            completion(CovidTrackerEntry.placeholder)
        } else {
            fetchCovidAPI(completion: completion)
        }
    }
    
    func fetchCovidAPI(completion: @escaping (Entry) -> Void) {
        
        covidAPIService.getCovidData(url:"https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/total", queryParam: ["country":"Australia"], completionHander: { result in
            switch(result) {
            
            case .success(let data):
                
                let countryData: CountryDataModel? = CountryDataModel.deserialization(data: data)
                
                if let countryData = countryData {
                    completion(Entry(date: Date(), countryData: countryData ))
                } else {
                    completion(Entry.placeholder)
                }
                
            case .failure(_):
                completion(Entry.placeholder)
            }
        })
    }

}
