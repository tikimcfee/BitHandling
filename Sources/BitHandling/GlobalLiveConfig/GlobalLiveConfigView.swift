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
            PlatformSection(header: Text("Grid Compute")) {
                ToggleView(title: "Support all file types", isOn: $config.preference.mobilePanXInvert)
                
                TextFieldView(
                    title: "Max Instances Per Grid",
                    value: Binding(
                        get: {
                            config.preference.maxInstancesPerGrid.float
                        },
                        set: {
                            config.preference.maxInstancesPerGrid = Int($0)
                        }),
                    formatter: NumberFormatter.intFormatter,
                    range: 1...50_000_000
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
                    range: 0...10000
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
                    range: 0...10000
                )
                TextFieldView(
                    title: "Camera Far Z",
                    value: $config.preference.cameraFarZ,
                    formatter: NumberFormatter.floatFormatter,
                    range: 0...100000
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
                    range: 0...1000000
                )
            }
            
            PlatformSection(header: Text("Syntax Coloring")) {
                ToggleView(title: "Colorize On Open", isOn: $config.preference.colorizeOnOpen)
                
                ColorPickerView(title: "AdditionOperator", color: $config.preference.coloring.additionOperator)
                ColorPickerView(title: "AnyDelimiter", color: $config.preference.coloring.anyDelimiter)
                ColorPickerView(title: "AnyKeyword", color: $config.preference.coloring.anyKeyword)
                ColorPickerView(title: "AnyOperator", color: $config.preference.coloring.anyOperator)
                ColorPickerView(title: "AnyVariable", color: $config.preference.coloring.anyVariable)
                ColorPickerView(title: "Bracket", color: $config.preference.coloring.bracket)
                ColorPickerView(title: "ClassDeclaration", color: $config.preference.coloring.classDeclaration)
                ColorPickerView(title: "ClassDefinition", color: $config.preference.coloring.classDefinition)
                ColorPickerView(title: "Colon", color: $config.preference.coloring.colon)
                ColorPickerView(title: "Comma", color: $config.preference.coloring.comma)
                ColorPickerView(title: "Comment", color: $config.preference.coloring.comment)
                ColorPickerView(title: "Conditional", color: $config.preference.coloring.conditional)
                ColorPickerView(title: "ConditionalGuard", color: $config.preference.coloring.conditionalGuard)
                ColorPickerView(title: "Constructor", color: $config.preference.coloring.constructor)
                ColorPickerView(title: "CurlyCloseBracket", color: $config.preference.coloring.curlyCloseBracket)
                ColorPickerView(title: "CurlyOpenBracket", color: $config.preference.coloring.curlyOpenBracket)
                ColorPickerView(title: "ElseKeyword", color: $config.preference.coloring.elseKeyword)
                ColorPickerView(title: "EnumDeclaration", color: $config.preference.coloring.enumDeclaration)
                ColorPickerView(title: "EqualOperator", color: $config.preference.coloring.equalOperator)
                ColorPickerView(title: "ExtensionDeclaration", color: $config.preference.coloring.extensionDeclaration)
                ColorPickerView(title: "ExtensionKeyword", color: $config.preference.coloring.extensionKeyword)
                ColorPickerView(title: "FloatLiteral", color: $config.preference.coloring.floatLiteral)
                ColorPickerView(title: "FunctionCallExpression", color: $config.preference.coloring.functionCallExpression)
                ColorPickerView(title: "FunctionDeclaration", color: $config.preference.coloring.functionDeclaration)
                ColorPickerView(title: "FunctionKeyword", color: $config.preference.coloring.functionKeyword)
                ColorPickerView(title: "GreaterThanOperator", color: $config.preference.coloring.greaterThanOperator)
                ColorPickerView(title: "ImportDefinition", color: $config.preference.coloring.importDefinition)
                ColorPickerView(title: "IncludeDirective", color: $config.preference.coloring.includeDirective)
                ColorPickerView(title: "InitConstructor", color: $config.preference.coloring.initConstructor)
                ColorPickerView(title: "InitName", color: $config.preference.coloring.initName)
                ColorPickerView(title: "IntegerLiteral", color: $config.preference.coloring.integerLiteral)
                ColorPickerView(title: "LessThanOperator", color: $config.preference.coloring.lessThanOperator)
                ColorPickerView(title: "LetKeyword", color: $config.preference.coloring.letKeyword)
                ColorPickerView(title: "LocalScopeClassDeclaration", color: $config.preference.coloring.localScopeClassDeclaration)
                ColorPickerView(title: "LocalScopeFunctionDeclaration", color: $config.preference.coloring.localScopeFunctionDeclaration)
                ColorPickerView(title: "LocalScopeGuardStatement", color: $config.preference.coloring.localScopeGuardStatement)
                ColorPickerView(title: "LocalScopePropertyDeclaration", color: $config.preference.coloring.localScopePropertyDeclaration)
                ColorPickerView(title: "LocalScopeStatements", color: $config.preference.coloring.localScopeStatements)
                ColorPickerView(title: "MacroFunction", color: $config.preference.coloring.macroFunction)
                ColorPickerView(title: "MemeberAccessExpression", color: $config.preference.coloring.memeberAccessExpression)
                ColorPickerView(title: "Method", color: $config.preference.coloring.method)
                ColorPickerView(title: "MethodDefinition", color: $config.preference.coloring.methodDefinition)
                ColorPickerView(title: "NumberLiteral", color: $config.preference.coloring.numberLiteral)
                ColorPickerView(title: "OperatorKeyword", color: $config.preference.coloring.operatorKeyword)
                ColorPickerView(title: "Parameter", color: $config.preference.coloring.parameter)
                ColorPickerView(title: "Period", color: $config.preference.coloring.period)
                ColorPickerView(title: "Property", color: $config.preference.coloring.property)
                ColorPickerView(title: "PropertyDefinition", color: $config.preference.coloring.propertyDefinition)
                ColorPickerView(title: "ProtocolDeclaration", color: $config.preference.coloring.protocolDeclaration)
                ColorPickerView(title: "RawBool", color: $config.preference.coloring.rawBool)
                ColorPickerView(title: "RawNumber", color: $config.preference.coloring.rawNumber)
                ColorPickerView(title: "RawString", color: $config.preference.coloring.rawString)
                ColorPickerView(title: "ReturnToken", color: $config.preference.coloring.returnToken)
                ColorPickerView(title: "RoundCloseBracket", color: $config.preference.coloring.roundCloseBracket)
                ColorPickerView(title: "RoundOpenBracket", color: $config.preference.coloring.roundOpenBracket)
                ColorPickerView(title: "SimpleIdentifierName", color: $config.preference.coloring.simpleIdentifierName)
                ColorPickerView(title: "SimpleTypeIdentifier", color: $config.preference.coloring.simpleTypeIdentifier)
                ColorPickerView(title: "SomeLabel", color: $config.preference.coloring.someLabel)
                ColorPickerView(title: "SomeRepeat", color: $config.preference.coloring.someRepeat)
                ColorPickerView(title: "SquareCloseBracket", color: $config.preference.coloring.squareCloseBracket)
                ColorPickerView(title: "SquareOpenBracket", color: $config.preference.coloring.squareOpenBracket)
                ColorPickerView(title: "StructDeclaration", color: $config.preference.coloring.structDeclaration)
                ColorPickerView(title: "SubtractionOperator", color: $config.preference.coloring.subtractionOperator)
                ColorPickerView(title: "ThrowKeyword", color: $config.preference.coloring.throwKeyword)
                ColorPickerView(title: "ThrowsKeyword", color: $config.preference.coloring.throwsKeyword)
                ColorPickerView(title: "Token", color: $config.preference.coloring.token)
                ColorPickerView(title: "TypeAliasDeclaration", color: $config.preference.coloring.typeAliasDeclaration)
                ColorPickerView(title: "TypeIdentifier", color: $config.preference.coloring.typeIdentifier)
                ColorPickerView(title: "TypeIdentifierName", color: $config.preference.coloring.typeIdentifierName)
                ColorPickerView(title: "UnknownToken", color: $config.preference.coloring.unknownToken)
                ColorPickerView(title: "VarableBuiltin", color: $config.preference.coloring.varableBuiltin)
                ColorPickerView(title: "VariableDeclaration", color: $config.preference.coloring.variableDeclaration)
                ColorPickerView(title: "VariableKeyword", color: $config.preference.coloring.variableKeyword)
                ColorPickerView(title: "VariablePattern", color: $config.preference.coloring.variablePattern)
                ColorPickerView(title: "VariableSelfExpression", color: $config.preference.coloring.variableSelfExpression)
                ColorPickerView(title: "VisibilityModifier", color: $config.preference.coloring.visibilityModifier)
                // Add more ColorPickerViews for the remaining TreeSitterColor properties
            }
        }
    }
}

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

struct GlobalLiveConfigEditor_Previews: PreviewProvider {
    static var previews: some View {
        GlobalLiveConfigEditor()
    }
}


struct ToggleView: View {
    var title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
    }
}

struct ColorPickerView: View {
    var title: String
    @Binding var color: SerialColor
    
    var body: some View {
        HStack {
            ColorPicker(title, selection: Binding(
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
            ))
            .layoutPriority(1)
//            .frame(width: 50, height: 50)
        }
    }
}
