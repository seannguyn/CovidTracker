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
    var coordinates: (lat: Double, long: Double) {
        switch stateCode {
        case "ACT":
            return (Double(-35.3546004), Double(149.2113468))
        case "NSW":
            return (Double(-31.840233), Double(145.612793))
        case "NT":
            return (Double(-19.491411), Double(132.550964))
        case "QLD":
            return (Double(-20.917574), Double(142.702789))
        case "SA":
            return (Double(-30.000233), Double(136.209152))
        case "TAS":
            return (Double(-40.83292234), Double(145.1166613))
        case "VIC":
            return (Double(-37.020100), Double(144.964600))
        case "WA":
            return (Double(-25.042261), Double(117.793221))
        default:
            return (Double(0),Double(0))
        }
    }
    
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
