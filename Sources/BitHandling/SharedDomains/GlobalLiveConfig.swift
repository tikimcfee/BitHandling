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
public struct GlobalLiveConfig {
    public static var Default = GlobalLiveConfig()
    
    // MARK: - Rendering
    public var cameraNearZ: Float = 0.1
    public var cameraFarZ: Float = 5000
    
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
    
    internal init() {
        
    }
}

public struct TreeSitterColor {
    public var comment              = NSUIColor(displayP3Red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    public var conditionalGuard     = NSUIColor(displayP3Red: 0.7, green: 0.2, blue: 0.6, alpha: 1.0)
    public var initConstructor      = NSUIColor(displayP3Red: 0.7, green: 0.5, blue: 0.6, alpha: 1.0)
    
    public var variableDeclaration     = NSUIColor(displayP3Red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
    public var extensionDeclaration    = NSUIColor(displayP3Red: 0.4, green: 0.6, blue: 0.6, alpha: 1.0)
    public var classDeclaration        = NSUIColor(displayP3Red: 0.5, green: 0.5, blue: 0.7, alpha: 1.0)
    public var structDeclaration       = NSUIColor(displayP3Red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
    public var functionDeclaration     = NSUIColor(displayP3Red: 0.123, green: 0.34, blue: 0.45, alpha: 1.0)
    public var token                   = NSUIColor(displayP3Red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    public var functionCallExpression  = NSUIColor(displayP3Red: 0.4, green: 0.4, blue: 0.9, alpha: 1.0)
    public var memeberAccessExpression = NSUIColor(displayP3Red: 0.8, green: 0.7, blue: 0.9, alpha: 1.0)
    public var protocolDeclaration     = NSUIColor(displayP3Red: 1.0, green: 0.8, blue: 0.9, alpha: 1.0)
    public var typeAliasDeclaration    = NSUIColor(displayP3Red: 1.0, green: 0.6, blue: 0.8, alpha: 1.0)
    public var enumDeclaration         = NSUIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    public var unknownToken = NSUIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
}
