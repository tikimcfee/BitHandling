//
//  TextFieldView.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//


import SwiftUI
import Combine

struct TextFieldView: View {
    var title: String
    @Binding var value: Float
    var formatter: NumberFormatter
    var range: ClosedRange<Float>
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
            Spacer()
            Text("[\(range.lowerBound, specifier: "%.2f"), \(range.upperBound, specifier: "%9.2f")]")
                .font(.caption)
                .monospaced()
            inputField
                .frame(width: 120)
        }
#if os(iOS)
        .keyboardType(.decimalPad)
#endif
    }
    
    var inputField: some View {
        TextField(
            "",
            value: Binding(
                get: { value },
                set: { newValue in
                    guard newValue != value else { return }
                    
                    if newValue < range.lowerBound {
                        value = range.lowerBound
                    } else if newValue > range.upperBound {
                        value = range.upperBound
                    } else {
                        value = newValue
                    }
                }
            ),
            formatter: formatter
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .textFieldStyle(.roundedBorder)
    }
}