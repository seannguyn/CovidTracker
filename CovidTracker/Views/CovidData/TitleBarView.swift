//
//  TitleBarView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI

struct TableDataView: View {
    @State private var width: CGFloat? = nil

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
            
            ForEach(0..<5, content: { index in
                
                HStack {
                    Text("Tasmania")
                        .bold()
                        .frame(width: 110, alignment: .leading)
                        .padding(.leading, 15)
                    
                    Spacer()
                    
                    Text("1000000")
                        .bold()
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text("1000000")
                        .bold()
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text("1000000")
                        .bold()
                        .padding(.horizontal, 5)
                    
                }
                
                Divider()
            })
            .onPreferenceChange(CenteringColumnPreferenceKey.self) { preferences in
                        for p in preferences {
                            let oldWidth = self.width ?? CGFloat.zero
                            if p.width > oldWidth {
                                self.width = p.width
                            }
                        }
                    }
            Spacer()
        }
        
    }
}

struct TitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        TableDataView()
    }
}


struct CenteringColumnPreferenceKey: PreferenceKey {
    typealias Value = [CenteringColumnPreference]

    static var defaultValue: [CenteringColumnPreference] = []

    static func reduce(value: inout [CenteringColumnPreference], nextValue: () -> [CenteringColumnPreference]) {
        value.append(contentsOf: nextValue())
    }
}

struct CenteringColumnPreference: Equatable {
    let width: CGFloat
}

struct CenteringView: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: CenteringColumnPreferenceKey.self,
                    value: [CenteringColumnPreference(width: geometry.frame(in: CoordinateSpace.global).width)]
                )
        }
    }
}
