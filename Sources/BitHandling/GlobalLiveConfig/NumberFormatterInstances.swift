//
//  NumberFormatterInstances.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//


import SwiftUI
import Combine

extension NumberFormatter {
    static var floatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    static var intFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 12
        return formatter
    }
}