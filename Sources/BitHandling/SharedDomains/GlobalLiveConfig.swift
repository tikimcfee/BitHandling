//  
//
//  Created on 12/16/23.
//  

import Foundation

// Finally, a bone.
public struct GlobalLiveConfig {
    public static var Default = GlobalLiveConfig()
    
    public var movementSpeed: Float = 50.0
    public var modifiedMovementSpeed: Float = 1000.0
    
    public var baseScrollSpeed: Float = 0.0
    public var baseKeyboardSpeed: Float = 0.0
    
    internal init() {
        
    }
}
