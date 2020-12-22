//
//  TileTitleView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI

struct TileTitleView: View {
    
    var title: String
    var number: String
    var textColor: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5).fill(Color("Tile")).frame(height: 70)
            .overlay(
                VStack {
                    Text("\(number)").bold().font(.title)
                    Text("\(title)").font(.title2)
                }
                    .foregroundColor(Color(textColor))
            )
    }
}

struct TileTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TileTitleView(title: "Confirmed", number: "1000", textColor: "TextNormal")
    }
}
