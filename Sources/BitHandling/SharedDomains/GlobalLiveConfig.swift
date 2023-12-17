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
    
    
    internal init() {
        
    }
}
