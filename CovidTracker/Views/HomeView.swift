//
//  ContentView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @ObservedObject var covidData = CovidDataViewModel()

    var body: some View {
        TabView {
           CovidDataView()
             .tabItem {
                Image(systemName: "chart.bar.xaxis")
                Text("Data")
              }
            
            CovidMapContainerView()
              .tabItem {
                 Image(systemName: "map.fill")
                 Text("Map")
               }
        }
        .environmentObject(covidData)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
