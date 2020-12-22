//
//  TileView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI

struct TileView: View {
    
    var title: String
    var number: String
    var textColor: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5).fill(Color("Tile")).frame(height: 60)
            .overlay(
                VStack {
                    Text("\(number)")
                    Text("\(title)")
                }
                    .foregroundColor(Color(textColor))
            )
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(title: "Confirmed", number: "1000", textColor: "TextRecover")
    }
}
