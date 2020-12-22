//
//  RowView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI

struct RowView: View {
    
    let color: Color
    let description: String
    let value: String
    
    var body: some View {
        
        HStack {
            Text("\(value)").font(.system(size: 20, weight: .semibold)).foregroundColor(.white)
            Text("\(description)").font(.system(size: 12, weight: .regular)).foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .foregroundColor(.white)
        .background(color.opacity(0.8))
        
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(color: Color("TextRecover"), description: "recovered", value: "117")
    }
}
