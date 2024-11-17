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
    public var uiAnimationDuration: Double = 1.0 / 8.0

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
    
    
    // MARK: - Grid layout
    public var codeGridGroupPadding: Float = 32.0
    public var codeGridGroupMaxRowWidth: Float = 5000.0
    public var codeGridGroupDepthPading: Float = -128.0
    
    // MARK: - Syntax
    public var colorizeOnOpen: Bool = true
    public var coloring: TreeSitterColor = TreeSitterColor()
    public var keymap: Keymap = Keymap()
    
    static var supportAllFiles: Bool = true
    
    static var supportedFileExtensions: Set<String> = [
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
        "plist", "resolved", "xcscheme"
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

public struct TreeSitterColor: Codable {
    public var rawString                        = SerialColor(red: 0.85, green: 0.55, blue: 0.25, alpha: 1.0)  // Amber Orange for strings
    public var rawBool                          = SerialColor(red: 0.9, green: 0.35, blue: 0.4, alpha: 1.0)   // Crimson Red for booleans
    public var rawNumber                        = SerialColor(red: 0.6, green: 0.75, blue: 0.95, alpha: 1.0)  // Sky Blue for numbers
    public var comment                          = SerialColor(red: 0.4, green: 0.5, blue: 0.4, alpha: 1.0)    // Olive Grey for comments
    public var conditionalGuard                 = SerialColor(red: 0.95, green: 0.75, blue: 0.25, alpha: 1.0) // Golden Yellow for conditional guards
    public var initConstructor                  = SerialColor(red: 0.75, green: 0.55, blue: 0.8, alpha: 1.0)  // Lavender Purple for initializers
    public var variableDeclaration              = SerialColor(red: 0.9, green: 0.6, blue: 0.6, alpha: 1.0)    // Light Coral for variable declarations
    public var extensionDeclaration             = SerialColor(red: 0.4, green: 0.7, blue: 0.7, alpha: 1.0)    // Sea Green for extensions
    public var classDeclaration                 = SerialColor(red: 0.55, green: 0.55, blue: 0.85, alpha: 1.0) // Soft Indigo for classes
    public var structDeclaration                = SerialColor(red: 0.85, green: 0.35, blue: 0.35, alpha: 1.0) // Rust Red for structs
    public var functionDeclaration              = SerialColor(red: 0.25, green: 0.6, blue: 0.85, alpha: 1.0)  // Azure for functions
    public var token                            = SerialColor(red: 0.95, green: 0.85, blue: 0.25, alpha: 1.0) // Goldenrod for generic tokens
    public var functionCallExpression           = SerialColor(red: 0.35, green: 0.55, blue: 0.85, alpha: 1.0) // Slate Blue for function calls
    public var memeberAccessExpression          = SerialColor(red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0)    // Pale Lilac for member accesses
    public var protocolDeclaration              = SerialColor(red: 0.95, green: 0.75, blue: 0.85, alpha: 1.0) // Soft Pink for protocols
    public var typeAliasDeclaration             = SerialColor(red: 0.95, green: 0.55, blue: 0.75, alpha: 1.0) // Pink Rose for type aliases
    public var enumDeclaration                  = SerialColor(red: 0.75, green: 0.85, blue: 0.95, alpha: 1.0) // Light Blue for enums
    public var returnToken                      = SerialColor(red: 0.4, green: 0.85, blue: 0.6, alpha: 1.0)   // Mint Green for return tokens
    public var unknownToken                     = SerialColor(red: 0.85, green: 0.25, blue: 0.25, alpha: 1.0) // Bright Red for unknown tokens
    public var someRepeat                       = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for repeats
    public var someLabel                        = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for labels
    public var conditional                      = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for conditionals
    public var constructor                      = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for constructors
    public var classDefinition                  = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for class definitions
    public var methodDefinition                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for method definitions
    public var propertyDefinition               = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for property definitions
    public var importDefinition                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for import definitions
    public var floatLiteral                     = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for float literals
    public var macroFunction                    = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for macro functions
    public var includeDirective                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for include directives
    public var anyKeyword                       = SerialColor(red: 0.8, green: 0.6, blue: 0.9, alpha: 1.0)    // Lavender for generic keywords
    public var elseKeyword                      = SerialColor(red: 0.95, green: 0.45, blue: 0.25, alpha: 1.0) // Sunset Orange for else keywords
    public var letKeyword                       = SerialColor(red: 0.85, green: 0.75, blue: 0.3, alpha: 1.0)  // Golden Yellow for let/var keywords
    public var throwKeyword                     = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for throw keywords
    public var throwsKeyword                    = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for throws keywords
    public var visibilityModifier               = SerialColor(red: 0.6, green: 0.75, blue: 0.95, alpha: 1.0)  // Sky Blue for visibility modifiers
    public var extensionKeyword                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for extension keywords
    public var functionKeyword                  = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for function keywords
    public var variableKeyword                  = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for variable keywords
    public var operatorKeyword                  = SerialColor(red: 0.9, green: 0.5, blue: 0.4, alpha: 1.0)    // Salmon Pink for operators
    public var localScopeClassDeclaration       = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for local scope class declarations
    public var localScopeFunctionDeclaration    = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for local scope function declarations
    public var localScopeGuardStatement         = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for local scope guard statements
    public var localScopePropertyDeclaration    = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for local scope property declarations
    public var localScopeStatements             = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for local scope statements
    public var method                           = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for methods
    public var initName                         = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for init names
    public var simpleIdentifierName             = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for simple identifier names
    public var typeIdentifierName               = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for type identifier names
    public var numberLiteral                    = SerialColor(red: 0.6, green: 0.75, blue: 0.95, alpha: 1.0)  // Sky Blue for number literals
    public var integerLiteral                   = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for integer literals
    public var anyOperator                      = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for any operators
    public var lessThanOperator                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for less than operators
    public var equalOperator                    = SerialColor(red: 0.85, green: 0.65, blue: 0.25, alpha: 1.0) // Honey Yellow for equals operator
    public var greaterThanOperator              = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for greater than operators
    public var additionOperator                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for addition operators
    public var subtractionOperator              = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for subtraction operators
    public var parameter                        = SerialColor(red: 0.5, green: 0.85, blue: 0.55, alpha: 1.0)  // Light Green for parameters
    public var property                         = SerialColor(red: 0.7, green: 0.7, blue: 0.9, alpha: 1.0)    // Periwinkle for properties
    public var bracket                          = SerialColor(red: 0.95, green: 0.85, blue: 0.25, alpha: 1.0) // Goldenrod for brackets
    public var roundOpenBracket                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for round open brackets
    public var roundCloseBracket                = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for round close brackets
    public var curlyOpenBracket                 = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for curly open brackets
    public var curlyCloseBracket                = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for curly close brackets
    public var squareOpenBracket                = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for square open brackets
    public var squareCloseBracket               = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for square close brackets
    public var anyDelimiter                     = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for any delimiters
    public var comma                            = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for commas
    public var period                           = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for periods
    public var colon                            = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for colons
    public var typeIdentifier                   = SerialColor(red: 0.6, green: 0.85, blue: 0.85, alpha: 1.0)  // Aqua for type identifiers
    public var simpleTypeIdentifier             = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for simple type identifiers
    public var anyVariable                      = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for any variables
    public var varableBuiltin                   = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for built-in variables
    public var variableSelfExpression           = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for self variable expressions
    public var variablePattern                  = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)    // Yellow for variable patterns
}


// Save it
extension GlobalLiveConfig: FlatFilePreference {
    public static var store = FlatFilePreferenceStore(GlobalLiveConfig())
    
    public var persistencePath: URL {
        AppFiles.globalConfigURL
    }
}
