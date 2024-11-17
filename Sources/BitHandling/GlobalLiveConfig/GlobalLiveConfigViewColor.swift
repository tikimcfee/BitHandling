//
//  GlobalLiveConfigColor.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/17/24.
//

import SwiftUI
import Combine

public struct GlobalLiveConfigEditorColor: View {
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
            PlatformSection(header: Text("Syntax Coloring")) {
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
            }
        }
    }
}
