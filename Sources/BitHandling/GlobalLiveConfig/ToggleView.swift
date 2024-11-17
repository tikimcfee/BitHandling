//
//  ToggleView.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//


import SwiftUI
import Combine

struct ToggleView: View {
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
    }
}