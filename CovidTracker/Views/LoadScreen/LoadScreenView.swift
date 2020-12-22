//
//  LoadScreenView.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 20/12/20.
//

import SwiftUI

struct LoadScreenView: View {
    
    @State var spin: Bool = false
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.red, Color.purple, Color.pink]
    
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)

    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle( lineWidth: 3, dash: [10]))
                    .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end))
                    .rotationEffect(.degrees(spin ? 360 : 0))
                    .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false))
                    .onAppear {
                        spin.toggle()
                    }
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end))
                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true))
                    .onReceive(timer, perform: { _ in
                        self.start = UnitPoint(x: 4, y: 0)
                        self.end = UnitPoint(x: 0, y: 2)
                        self.start = UnitPoint(x: -4, y: 20)
                        self.start = UnitPoint(x: 4, y: 0)
                    })
                    .frame(width: 125, height: 125, alignment: .center)
            }
                .frame(width: 150, height: 150, alignment: .center)
            
            Text("...Loading...")
        }
    }
}

struct LoadScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoadScreenView()
    }
}
