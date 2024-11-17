//  
//
//  Created on 12/16/23.
//  

import Foundation
#if os(macOS)
import AppKit
public typealias NSUIColor = NSColor
#else
import SwiftUI
public typealias NSUIColor = UIColor
#endif

// Finally, a bone.
public struct GlobalLiveConfig: Codable {
    // MARK: - Rendering
    public var cameraFieldOfView: Float = Float.pi / 3.0
    public var cameraNearZ: Float = 2.0
    public var cameraFarZ: Float = 64_000.0
    
    // MARK: - Controls
    public var uiAnimationDuration: Float = 1.0 / 8.0

    public var movementSpeed: Float = 50.0
    public var movementSpeedModified: Float = 1000.0
    public var movementYawMagnitude: Float = 5.0
    
    public var scrollSpeed: Float = 50.0
    public var scrollSpeedModified: Float = 1000.0
    
    public var mobilePanXMultiplier: Float = 250
    public var mobilePanYMultiplier: Float = 250
    public var mobilePanXInvert: Bool = false
    public var mobilePanYInvert: Bool = false
    public var mobilePanXComputed: Float { mobilePanXMultiplier * (mobilePanXInvert ? -1 : 1) }
    public var mobilePanYComputed: Float { mobilePanYMultiplier * (mobilePanYInvert ? -1 : 1) }
    
    public var magnificationRawMultiplier: Float = 100_000
    
    // MARK: - Grid compute
    public var maxInstancesPerGrid: Int = 100_000 // Compute this for chipset combo? (cpu/gpu/memory)
    public var maxFileSizePerGridMegabytes: Float = 1.0 // Compute this for chipset combo? (cpu/gpu/memory)
    
    
    // MARK: - Grid layout
    public var codeGridGroupPadding: Float = 32.0
    public var codeGridGroupMaxRowWidth: Float = 5000.0
    public var codeGridGroupDepthPading: Float = -128.0
    
    // MARK: - Syntax
    public var colorizeOnOpen: Bool = true
    public var coloring: TreeSitterColor = TreeSitterColor()
    public var keymap: Keymap = Keymap()
    
    public var supportAllFiles: Bool = true
    
    public var supportedFileExtensions: Set<String> = [
        "swift", "metal",
        "m", "mm",
        "cpp", "c", "cs", "h",
        "md", "txt",
        "py",
        "java", "kt",
        "html", "css", "js", "ts", "tsx", "jsx", "scss",
        "json", "xml",
        "rs",
        "go",
        "sh",
        "pbxproj", "xcworkspace", "storyboard",
        "plist", "resolved", "xcscheme",
        "scm"
    ]
    
    public var supportedColorizedExtensions: Set<String> = [
        "swift"
    ]
    
    static var unsupportedExtensions: Set<String> = [
        "xcassets", "git"
    ]
    
    public init() {
        
    }
}

public struct Keymap: Codable {
    public static let movement: [String: SelfRelativeDirection] = [
        "a": .left,
        "A": .left,
        "d": .right,
        "D": .right,
        "w": .forward,
        "W": .forward,
        "s": .backward,
        "S": .backward,
        "z": .down,
        "Z": .down,
        "x": .up,
        "X": .up,
        "q": .yawLeft,
        "Q": .yawLeft,
        "e": .yawRight,
        "E": .yawRight,
    ]
    
    public static let focus: [String: SelfRelativeDirection] = [
        "h": .left,
        "H": .left,
        "l": .right,
        "L": .right,
        "j": .down,
        "J": .down,
        "k": .up,
        "K": .up,
        "n": .forward,
        "N": .forward,
        "m": .backward,
        "M": .backward,
    ]
    
    public var movement = Self.movement
    public var focus = Self.focus
}

// Use a non-zero blue for multiplication; 255 * 0.006 = 1.53
public struct TreeSitterColor: Codable {
    public var additionOperator               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var anyDelimiter                   = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var anyKeyword                     = SerialColor(red: 0.8,    green: 0.6,    blue: 0.9,     alpha: 1.0)
    public var anyOperator                    = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var anyVariable                    = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var bracket                        = SerialColor(red: 0.95,   green: 0.85,   blue: 0.25,    alpha: 1.0)
    public var classDeclaration               = SerialColor(red: 0.55,   green: 0.55,   blue: 0.85,    alpha: 1.0)
    public var classDefinition                = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var colon                          = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var comma                          = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var comment                        = SerialColor(red: 0.4,    green: 0.5,    blue: 0.4,     alpha: 1.0)
    public var conditional                    = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var conditionalGuard               = SerialColor(red: 0.95,   green: 0.75,   blue: 0.25,    alpha: 1.0)
    public var constructor                    = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var curlyCloseBracket              = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var curlyOpenBracket               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var elseKeyword                    = SerialColor(red: 0.95,   green: 0.45,   blue: 0.25,    alpha: 1.0)
    public var enumDeclaration                = SerialColor(red: 0.75,   green: 0.85,   blue: 0.95,    alpha: 1.0)
    public var equalOperator                  = SerialColor(red: 0.85,   green: 0.65,   blue: 0.25,    alpha: 1.0)
    public var extensionDeclaration           = SerialColor(red: 0.4,    green: 0.7,    blue: 0.7,     alpha: 1.0)
    public var extensionKeyword               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var floatLiteral                   = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var functionCallExpression         = SerialColor(red: 0.35,   green: 0.55,   blue: 0.85,    alpha: 1.0)
    public var functionDeclaration            = SerialColor(red: 0.25,   green: 0.6,    blue: 0.85,    alpha: 1.0)
    public var functionKeyword                = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var greaterThanOperator            = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var importDefinition               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var includeDirective               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var initConstructor                = SerialColor(red: 0.75,   green: 0.55,   blue: 0.8,     alpha: 1.0)
    public var initName                       = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var integerLiteral                 = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var lessThanOperator               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var letKeyword                     = SerialColor(red: 0.85,   green: 0.75,   blue: 0.3,     alpha: 1.0)
    public var localScopeClassDeclaration     = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var localScopeFunctionDeclaration  = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var localScopeGuardStatement       = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var localScopePropertyDeclaration  = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var localScopeStatements           = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var macroFunction                  = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var memeberAccessExpression        = SerialColor(red: 0.8,    green: 0.7,    blue: 0.9,     alpha: 1.0)
    public var method                         = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var methodDefinition               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var numberLiteral                  = SerialColor(red: 0.6,    green: 0.75,   blue: 0.95,    alpha: 1.0)
    public var operatorKeyword                = SerialColor(red: 0.9,    green: 0.5,    blue: 0.4,     alpha: 1.0)
    public var parameter                      = SerialColor(red: 0.5,    green: 0.85,   blue: 0.55,    alpha: 1.0)
    public var period                         = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var property                       = SerialColor(red: 0.7,    green: 0.7,    blue: 0.9,     alpha: 1.0)
    public var propertyDefinition             = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var protocolDeclaration            = SerialColor(red: 0.95,   green: 0.75,   blue: 0.85,    alpha: 1.0)
    public var rawBool                        = SerialColor(red: 0.9,    green: 0.35,   blue: 0.4,     alpha: 1.0)
    public var rawNumber                      = SerialColor(red: 0.6,    green: 0.75,   blue: 0.95,    alpha: 1.0)
    public var rawString                      = SerialColor(red: 0.85,   green: 0.55,   blue: 0.25,    alpha: 1.0)
    public var returnToken                    = SerialColor(red: 0.4,    green: 0.85,   blue: 0.6,     alpha: 1.0)
    public var roundCloseBracket              = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var roundOpenBracket               = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var simpleIdentifierName           = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var simpleTypeIdentifier           = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var someLabel                      = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var someRepeat                     = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var squareCloseBracket             = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var squareOpenBracket              = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var structDeclaration              = SerialColor(red: 0.85,   green: 0.35,   blue: 0.35,    alpha: 1.0)
    public var subtractionOperator            = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var throwKeyword                   = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var throwsKeyword                  = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var token                          = SerialColor(red: 0.95,   green: 0.85,   blue: 0.25,    alpha: 1.0)
    public var typeAliasDeclaration           = SerialColor(red: 0.95,   green: 0.55,   blue: 0.75,    alpha: 1.0)
    public var typeIdentifier                 = SerialColor(red: 0.6,    green: 0.85,   blue: 0.85,    alpha: 1.0)
    public var typeIdentifierName             = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var unknownToken                   = SerialColor(red: 0.85,   green: 0.25,   blue: 0.25,    alpha: 1.0)
    public var varableBuiltin                 = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var variableDeclaration            = SerialColor(red: 0.9,    green: 0.6,    blue: 0.6,     alpha: 1.0)
    public var variableKeyword                = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var variablePattern                = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var variableSelfExpression         = SerialColor(red: 1.0,    green: 1.0,    blue: 0.006,   alpha: 1.0)
    public var visibilityModifier             = SerialColor(red: 0.6,    green: 0.75,   blue: 0.95,    alpha: 1.0)
}


// Save it
extension GlobalLiveConfig: FlatFilePreference {
    public static var store = FlatFilePreferenceStore(GlobalLiveConfig())
    
    public var persistencePath: URL {
        AppFiles.globalConfigURL
    }
}
