//
//  CovidMapContainerView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 23/12/20.
//

import SwiftUI

struct CovidMapContainerView: View {
    var body: some View {
        CovidMapView()
            .ignoresSafeArea(edges: .top)
    }
}

struct CovidMapContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CovidMapContainerView()
    }
}
