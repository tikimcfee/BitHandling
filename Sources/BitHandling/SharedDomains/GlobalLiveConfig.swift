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

public extension GlobalLiveConfig {
    static var Default = load()
    
    static func saveDefault() {
        do {
            let data = try JSONEncoder().encode(Default)
            try data.write(to: AppFiles.globalConfigURL)
        } catch {
            print(error)
        }
    }
    
    static func reloadDefault() {
        Default = load()
    }
    
    private static func load() -> GlobalLiveConfig {
        do {
            let data = try Data(contentsOf: AppFiles.globalConfigURL)
            return try JSONDecoder().decode(GlobalLiveConfig.self, from: data)
        } catch {
            print(error)
            return GlobalLiveConfig()
        }
    }
}

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
    
    // MARK: - Syntax
    public var coloring: TreeSitterColor = TreeSitterColor()
    public var keymap: Keymap = Keymap()
    
    internal init() {
        
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
    public var rawString               = SerialColor(red: 0.6, green: 0.5, blue: 0.4, alpha: 1.0)
    public var rawBool                 = SerialColor(red: 0.9, green: 0.8, blue: 0.7, alpha: 1.0)
    public var rawNumber               = SerialColor(red: 0.8, green: 0.9, blue: 0.9, alpha: 1.0)
    public var comment                 = SerialColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    public var conditionalGuard        = SerialColor(red: 0.7, green: 0.2, blue: 0.6, alpha: 1.0)
    public var initConstructor         = SerialColor(red: 0.7, green: 0.5, blue: 0.6, alpha: 1.0)
    public var variableDeclaration     = SerialColor(red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
    public var extensionDeclaration    = SerialColor(red: 0.4, green: 0.6, blue: 0.6, alpha: 1.0)
    public var classDeclaration        = SerialColor(red: 0.5, green: 0.5, blue: 0.7, alpha: 1.0)
    public var structDeclaration       = SerialColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
    public var functionDeclaration     = SerialColor(red: 0.123, green: 0.34, blue: 0.45, alpha: 1.0)
    public var token                   = SerialColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    public var functionCallExpression  = SerialColor(red: 0.4, green: 0.4, blue: 0.9, alpha: 1.0)
    public var memeberAccessExpression = SerialColor(red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0)
    public var protocolDeclaration     = SerialColor(red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    public var typeAliasDeclaration    = SerialColor(red: 1.0, green: 0.6, blue: 0.8, alpha: 1.0)
    public var enumDeclaration         = SerialColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public var returnToken             = SerialColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)

    public var unknownToken            = SerialColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
}
