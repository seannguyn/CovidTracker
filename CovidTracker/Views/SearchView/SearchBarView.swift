//
//  SearchBarView.swift
//  DigitalReport
//
//  Created by Sean.S.Nguyen on 25/10/20.
//  Copyright © 2020 Sean.S.Nguyen. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    @Binding var showSearchBar: Bool
    
    var body: some View {
        HStack {
            TextField("Quick Search...", text: $searchText)
                .padding(15)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .foregroundColor(.gray)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                        
                        if (isEditing && !searchText.isEmpty) {
                            Spacer()
                            Button(action: {
                                self.searchText = ""
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
            
            if self.isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                        self.searchText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        showSearchBar = false
                    }
                }){
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.opacity)
                .animation(.default)
            }
        }
//        .padding([.top, .leading, .trailing])
//        .padding(.bottom, 0.5)
        .padding([.horizontal, .top], 5)
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
