//
//  TitleView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 22/12/20.
//

import SwiftUI
import WidgetKit

struct TitleView: View {
    
    var date: Date
    
    var body: some View {
        HStack {
            Text("🇦🇺").font(.system(size: 16, weight: .semibold))
            Text(date, style: .time).font(.system(size: 16, weight: .semibold))
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}
 
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(date: Date()).previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
