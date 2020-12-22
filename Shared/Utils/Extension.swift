//
//  Extension.swift
//  CovidTracker
//
//  Created by Sean.S.Nguyen on 20/12/20.
//
import Foundation

extension Int64 {
    
    func formatNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
}

extension Double {
    
    func formatPercentage() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    
}

extension String {
    func normalizeString() -> String {
        return self.replacingOccurrences(of: " ", with: "").lowercased()
    }
}
