//
//  ColorPickerView.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//


import SwiftUI
import Combine

struct ColorPickerView: View {
    var title: String
    @Binding var color: SerialColor
    
    var body: some View {
        HStack {
            ColorPicker(
                title,
                selection: Binding(
                    get: { Color(NSUIColor(
                        red: CGFloat(color.red),
                        green: CGFloat(color.green),
                        blue: CGFloat(color.blue),
                        alpha: CGFloat(color.alpha))
                    )},
                    set: { newColor in
                        if let components = newColor.cgColor?.components {
                            color = SerialColor(
                                red: Float(components[0]),
                                green: Float(components[1]),
                                blue: Float(components[2]),
                                alpha: Float(components[3])
                            )
                        }
                    }
                ),
                supportsOpacity: false
            )
            .layoutPriority(1)
        }
    }
}