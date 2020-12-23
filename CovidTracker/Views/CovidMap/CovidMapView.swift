//
//  CovidMapView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 19/12/20.
//

import SwiftUI
import MapKit
import UIKit

struct CovidMapView: UIViewRepresentable {
    
    @EnvironmentObject var covidData: CovidDataViewModel
    
    func makeUIView(context: UIViewRepresentableContext<CovidMapView>) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        var allAnnotations: [CovidMapAnnotation] = []
        
        if let allStateTerritoryData = covidData.allStateTerritoryData {
            for stateTerritory in allStateTerritoryData {
                
                let title = stateTerritory.province + "\n Confirmed " + stateTerritory.confirmed.formatNumber() + "\n Death " + stateTerritory.deaths.formatNumber()
                
                let mapAnnotation = CovidMapAnnotation(title: title, coordinate: CLLocationCoordinate2D(latitude: stateTerritory.coordinates.lat, longitude: stateTerritory.coordinates.long))
                
                allAnnotations.append(mapAnnotation)
            }
        }
        
        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        uiView.addAnnotations(allAnnotations)
    }
}

class CovidMapAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}

struct CovidMapView_Previews: PreviewProvider {
    static var previews: some View {
        CovidMapView()
    }
}
