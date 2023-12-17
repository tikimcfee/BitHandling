//  
//
//  Created on 12/16/23.
//  

import Foundation

// Finally, a bone.
public struct GlobalLiveConfig {
    public static var Default = GlobalLiveConfig()
    
    public var cameraNearZ: Float = 0.1
    public var cameraFarZ: Float = 5000
    
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
    
    internal init() {
        
    }
}
