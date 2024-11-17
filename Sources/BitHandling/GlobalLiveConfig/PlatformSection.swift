//
//  PlatformSection.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//


import SwiftUI
import Combine

struct PlatformSection<Content: View>: View {
    let header: Text
    let content: () -> Content
    
    init(
        header: Text,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        //        #if os(iOS)
        Section(header: header, content: content)
        //        #else
        //        VStack(alignment: .leading) {
        //            header
        //            content()
        //        }
        //        #endif
    }
}