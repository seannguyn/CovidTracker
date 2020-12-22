//
//  StateTerritoryDataModel.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import Foundation

public struct StateTerritoryDataModel: Codable, Identifiable {
    
    public var id = UUID()
    let province: String
    var stateCode: String {
        switch province {
        case "Australian Capital Territory":
            return "ACT"
        case "New South Wales":
            return "NSW"
        case "Northern Territory":
            return "NT"
        case "Queensland":
            return "QLD"
        case "South Australia":
            return "SA"
        case "Tasmania":
            return "TAS"
        case "Victoria":
            return "VIC"
        case "Western Australia":
            return "WA"
        default:
            return ""
        }
    }
    var searchString: String {
        return stateCode.normalizeString() + province.normalizeString()
    }
    let country: String
    let lastUpdate: String
    let keyId: String
    let confirmed: Int64
    var active: Int64 {
        return confirmed - deaths - recovered
    }
    let deaths: Int64
    let recovered: Int64
    
    init?(json: [String: Any]) throws {
        guard let province = json["province"] as? String,
                    let country = json["country"] as? String,
                    let lastUpdate = json["lastUpdate"] as? String,
                    let keyId = json["keyId"] as? String,
                    let confirmed = json["confirmed"] as? Int64,
                    let deaths = json["deaths"] as? Int64,
                    let recovered = json["recovered"] as? Int64
                else {
                    return nil
                }
        
        self.province = province
        self.country = country
        self.lastUpdate = lastUpdate
        self.keyId = keyId
        self.confirmed = confirmed
        self.deaths = deaths
        self.recovered = recovered
    }
    
    static func deserialization(data: Data) -> [StateTerritoryDataModel] {
        
        var stateTerritoryDataArray: [StateTerritoryDataModel] = []
        
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let responseData = json as? [String: Any] {
            
            if let arrayData0 = responseData["data"] as? [String: Any] {
                
                if let arrayData1 = arrayData0["covid19Stats"] as? [[String: Any]] {
                    for item in arrayData1 {
                        if let stateTerritory = try? StateTerritoryDataModel(json: item) {
                            stateTerritoryDataArray.append(stateTerritory)
                        }
                    }
                }
            }
        }
        
        return stateTerritoryDataArray
    }
}
