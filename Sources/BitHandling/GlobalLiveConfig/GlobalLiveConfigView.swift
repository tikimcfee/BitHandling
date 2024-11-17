//
//  GlobalLiveConfigView.swift
//  SwiftGlyph
//
//  Created by Ivan Lugo on 11/16/24.
//

import SwiftUI
import Combine

public struct GlobalLiveConfigEditor: View {
    @ObservedObject private var config = GlobalLiveConfig.store
    
    public init() {
        
    }
    
    public var body: some View {
        mainContent
            .listStyle(.inset)
            .frame(maxWidth: 500)
    }
    
    public var mainContent: some View {
        List {
            PlatformSection(header: Text("File Loading")) {
                ToggleView(title: "Support all file types", isOn: $config.preference.supportAllFiles)
                HStack(alignment: .top) {
                    Text("Rendered Files")
                        .frame(width: 100)
                    TextField(
                        "Enter a comma separated list of file extensions for rendering.",
                        text: Binding(
                            get: {
                                config.preference
                                    .supportedFileExtensions
                                    .sorted(by: { $0 < $1 })
                                    .joined(separator: ", ")
                            },
                            set: { newValue in
                                let values = newValue
                                    .split(separator: ",")
                                    .lazy
                                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                                
                                config.preference
                                    .supportedFileExtensions = Set(Array(values))
                            }
                        ),
                        axis: .vertical
                    )
                    .lineLimit(5, reservesSpace: true)
                }
                
                ToggleView(title: "Colorize On Open", isOn: $config.preference.colorizeOnOpen)
                HStack(alignment: .top) {
                    Text("Colorized Files")
                        .frame(width: 100)
                    
                    TextField(
                        "Enter a comma separated list of file extensions for colorizing.",
                        text: Binding(
                            get: {
                                config.preference
                                    .supportedColorizedExtensions
                                    .sorted(by: { $0 < $1 })
                                    .joined(separator: ", ")
                            },
                            set: { newValue in
                                let values = newValue
                                    .split(separator: ",")
                                    .lazy
                                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                                
                                config.preference
                                    .supportedColorizedExtensions = Set(Array(values))
                            }
                        ),
                        axis: .vertical
                    )
                    .lineLimit(5, reservesSpace: true)
                }
            }
            
            PlatformSection(header: Text("Grid Compute")) {
                TextFieldView(
                    title: "Characters Per Grid Page",
                    value: Binding(
                        get: {
                            config.preference.maxInstancesPerGrid.float
                        },
                        set: {
                            config.preference.maxInstancesPerGrid = Int($0)
                        }),
                    formatter: NumberFormatter.intFormatter,
                    range: 1...500_000_000
                )
                
                TextFieldView(
                    title: "Max Filesize, in MB",
                    value: $config.preference.maxFileSizePerGridMegabytes,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0.1...100
                )
            }
            
            PlatformSection(header: Text("Grid Layout")) {
                TextFieldView(
                    title: "Grid Group Padding",
                    value: $config.preference.codeGridGroupPadding,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...1000
                )
                TextFieldView(
                    title: "Grid Max Row Width",
                    value: $config.preference.codeGridGroupMaxRowWidth,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...10_000
                )
                TextFieldView(
                    title: "Grid Depth Padding",
                    value: $config.preference.codeGridGroupDepthPading,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...1000
                )
            }
            
            PlatformSection(header: Text("Rendering")) {
                TextFieldView(
                    title: "Camera FOV",
                    value: $config.preference.cameraFieldOfView,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0.1...(Float.pi)
                )
                TextFieldView(
                    title: "Camera Near Z",
                    value: $config.preference.cameraNearZ,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...10_000
                )
                TextFieldView(
                    title: "Camera Far Z",
                    value: $config.preference.cameraFarZ,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...100_000
                )
            }
            
            PlatformSection(header: Text("Controls")) {
                ToggleView(title: "Invert Mobile Pan X", isOn: $config.preference.mobilePanXInvert)
                ToggleView(title: "Invert Mobile Pan Y", isOn: $config.preference.mobilePanYInvert)
                TextFieldView(
                    title: "UI Animation Duration",
                    value: $config.preference.uiAnimationDuration,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0.01...5.0
                )
                TextFieldView(
                    title: "Movement Speed",
                    value: $config.preference.movementSpeed,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...5000
                )
                TextFieldView(
                    title: "Movement Speed Modified",
                    value: $config.preference.movementSpeedModified,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...5000
                )
                TextFieldView(
                    title: "Movement Yaw Magnitude",
                    value: $config.preference.movementYawMagnitude,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...20
                )
                TextFieldView(
                    title: "Scroll Speed",
                    value: $config.preference.scrollSpeed,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...5000
                )
                TextFieldView(
                    title: "Scroll Speed Modified",
                    value: $config.preference.scrollSpeedModified,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...5000
                )
                TextFieldView(
                    title: "Mobile Pan X Multiplier",
                    value: $config.preference.mobilePanXMultiplier,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...1000
                )
                TextFieldView(
                    title: "Mobile Pan Y Multiplier",
                    value: $config.preference.mobilePanYMultiplier,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...1000
                )
                TextFieldView(
                    title: "Magnification Raw Multiplier",
                    value: $config.preference.magnificationRawMultiplier,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...1_000_000
                )
            }
        }
    }
}



struct GlobalLiveConfigEditor_Previews: PreviewProvider {
    static var previews: some View {
        GlobalLiveConfigEditor()
    }
}


