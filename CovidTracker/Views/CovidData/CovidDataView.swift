//
//  CovidDataView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI

struct CovidDataView: View {
    
    @State var searchState: String = ""
    @State var showSearchBar: Bool = false
    @EnvironmentObject var covidData: CovidDataViewModel
       
    var body: some View {
        NavigationView {
            if covidData.countryData == nil || covidData.allStateTerritoryData == nil {
                LoadScreenView()
            } else {
                VStack(spacing: 5){
                    if (showSearchBar) {
                        SearchBarView(searchText: $searchState, showSearchBar: $showSearchBar)
                    }
                    
                    HStack {
                        TileTitleView(title: "Confirmed", number: "\(covidData.countryData!.confirmed.formatNumber())", textColor: "TextNormal")
                    }
                        .padding([.horizontal],5)
                        .padding([.top], showSearchBar ? 0 : 5)
                    
                    HStack {
                        TileView(title: "Recovered", number: "\(covidData.countryData!.recovered.formatNumber())", textColor: "TextRecover")
                        TileView(title: "Active", number: "\(covidData.countryData!.active.formatNumber())", textColor: "TextActive")
                        TileView(title: "Death", number: "\(covidData.countryData!.deaths.formatNumber())", textColor: "TextDeath")
                    }
                        .padding([.horizontal], 5)
                                    
                    PieChartView()
                    TableDataView(searchState: $searchState)
                }
                    .navigationBarTitleDisplayMode(.inline)
                            .toolbar { // <2>
                                ToolbarItem(placement: .principal) { // <3>
                                    VStack {
                                        HStack {
                                            Text("🇦🇺")
                                            Text("Australia")
                                        }
                                        .font(.system(size: 25))
                                        
                                        if covidData.lastUpdated != "" {
                                            Text("\(covidData.lastUpdated)")
                                                .font(.system(size: 10))
                                                .padding(.bottom, 2)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing) { // <3>
                                    Image(systemName: "magnifyingglass").onTapGesture {
                                        self.showSearchBar.toggle()
                                    }
                                }
                            }
            }
        }
    }
}

struct CovidDataView_Previews: PreviewProvider {
    static var previews: some View {
        CovidDataView()
    }
}
