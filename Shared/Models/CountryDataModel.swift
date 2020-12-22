//
//  CountryDataModel.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import Foundation
import SwiftUI

public struct CountryDataModel: Codable {
    let recovered: Int64
    let deaths: Int64
    let confirmed: Int64
    var active: Int64 {
        return confirmed - deaths - recovered
    }
    let lastChecked: String
    let lastReported: String
    let location: String
    var pieChart: PieChartModel {
        return PieChartModel(data: [active, recovered, deaths], labels: ["Active", "Recover", "Death"], colors: [Color("TextActive"), Color("TextRecover"), Color("TextDeath")])
    }
    
    init?(json: [String: Any]) throws {
        guard let recovered = json["recovered"] as? Int64,
                 let deaths = json["deaths"] as? Int64,
                 let confirmed = json["confirmed"] as? Int64,
                 let lastChecked = json["lastChecked"] as? String,
                 let lastReported = json["lastReported"] as? String,
                 let location = json["location"] as? String else {
            return nil
        }
        
        self.recovered = recovered
        self.deaths = deaths
        self.confirmed = confirmed
        self.lastChecked = lastChecked
        self.lastReported = lastReported
        self.location = location
    }
    
    init(recovered: Int64, deaths: Int64, confirmed: Int64) {
        self.recovered = recovered
        self.deaths = deaths
        self.confirmed = confirmed
        self.lastChecked = ""
        self.lastReported = ""
        self.location = "Australia"
    }
    
    static func deserialization(data: Data) -> CountryDataModel? {
        
        var countryDataModel: CountryDataModel?
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let responseData = json as? [String: Any] {
            
            if let tempData = responseData["data"] as? [String: Any] {
                if let tempCountryDataModel = try? CountryDataModel(json: tempData) {
                    countryDataModel = tempCountryDataModel
                }
            }
        }
        
        return countryDataModel
    }
}
