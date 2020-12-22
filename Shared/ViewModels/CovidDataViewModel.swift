//
//  CovidDataViewModel.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import Foundation
class CovidDataViewModel: ObservableObject {
    
    // MARK: Published variables
    @Published var allStateTerritoryData: [StateTerritoryDataModel]?
    @Published var countryData: CountryDataModel?
    @Published var lastUpdated: String = ""
    private var timer: Timer?
    
    init() {
        
        LoadData()
        
        timer = Timer.scheduledTimer(withTimeInterval: 120, repeats: true) { timer in
            self.LoadData()
        }
    }
    
    func LoadData() {
        CovidAPIService.shared.getCovidData(url: "https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/stats", queryParam: ["country":"Australia"], completionHander: { result in
            switch(result) {
                case .success(let data):
                    self.allStateTerritoryData = StateTerritoryDataModel.deserialization(data: data)
                    self.lastUpdated = self.getCurrentTimeString()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })

        CovidAPIService.shared.getCovidData(url: "https://covid-19-coronavirus-statistics.p.rapidapi.com/v1/total", queryParam: ["country":"Australia"], completionHander: { result in
            switch(result) {
                case .success(let data):
                    self.countryData = CountryDataModel.deserialization(data: data)
                    self.lastUpdated = self.getCurrentTimeString()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        })
    }
    
    func getCurrentTimeString() -> String {
        let currentDateTime = Date()
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm E, d MMM y"
        
        return formatter3.string(from: currentDateTime)
    }
}
