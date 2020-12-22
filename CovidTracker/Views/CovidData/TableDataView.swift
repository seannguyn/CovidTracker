//
//  TitleBarView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI

struct TableDataView: View {
    
    @EnvironmentObject var covidData: CovidDataViewModel
    @Binding var searchState: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 0).fill(Color("Tile")).frame(height: 35)
                .overlay(
                    HStack {
                        Text("State")
                            .bold()
                            .frame(width: 110, alignment: .leading)
                            .padding(.leading, 15)
                        
                        Spacer()
                        
                        Text("Conf.")
                            .bold()
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("Active")
                            .bold()
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("Recover")
                            .bold()
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Text("Death")
                            .bold()
                            .padding(.leading, 5)
                        Spacer()
                    }
                )
            
            ScrollView(.vertical) {
                ForEach(covidData.allStateTerritoryData!.filter( { (stateTerritory) -> Bool in
                    
                    let normalizeSearchState = searchState.normalizeString()
                    
                    let willInclude = stateTerritory.searchString.contains(normalizeSearchState)
                    
                    return willInclude || normalizeSearchState == ""
                    
                } )) { stateTerritory in
                    HStack {
                        Text("\(stateTerritory.stateCode)")
                            .bold()
                            .frame(width: 110, alignment: .leading)
                            .padding(.leading, 15)
                            .foregroundColor(Color("TextNormal"))
                        
                        Spacer()
                        
                        Text("\(stateTerritory.confirmed)")
                            .padding(.trailing)
                            .foregroundColor(Color("TextNormal"))
                        
                        Spacer()
                        
                        Text("\(stateTerritory.active)")
                            .padding(.trailing)
                            .foregroundColor(Color("TextActive"))
                        
                        Spacer()
                        
                        Text("\(stateTerritory.recovered)")
                            .padding(.trailing)
                            .foregroundColor(Color("TextRecover"))
                        
                        Spacer()
                        
                        Text("\(stateTerritory.deaths)")
                            .padding(.trailing)
                            .foregroundColor(Color("TextDeath"))
                        
                        
                    }
                    Divider()
                }
            }
            Spacer()
        }
        
    }
}

struct TitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Text("hey")
        }
    }
}
