//  
//
//  Created on 12/16/23.
//  

import Foundation


#if os(macOS)
import AppKit

extension NSEvent.ModifierFlags: @retroactive CustomStringConvertible {
    public var description: String {
        var modifiers = ""
        
        func add(_ name: String) {
            modifiers = modifiers.isEmpty ? name : "\(modifiers) + \(name)"
        }

        if self.contains(NSEvent.ModifierFlags.capsLock) {
            add("capsLock")
        }
        if self.contains(NSEvent.ModifierFlags.shift) {
            add("shift")
        }
        if self.contains(NSEvent.ModifierFlags.control) {
            add("control")
        }
        if self.contains(NSEvent.ModifierFlags.option) {
            add("option")
        }
        if self.contains(NSEvent.ModifierFlags.command) {
            add("command")
        }
        if self.contains(NSEvent.ModifierFlags.numericPad) {
            add("numericPad")
        }
        if self.contains(NSEvent.ModifierFlags.help) {
            add("help")
        }
        if self.contains(NSEvent.ModifierFlags.function) {
            add("function")
        }
        if self.contains(NSEvent.ModifierFlags.deviceIndependentFlagsMask) {
            add("mask")
        }

        if modifiers.isEmpty {
            add("unknown-modifier-\(rawValue)")
        }

        return modifiers
    }
    
    public var __unsafe__isUnknown: Bool {
        rawValue == 256
    }
}

extension NSEvent.EventType: @retroactive CustomStringConvertible {
    public var description: String {
        switch self {
        case .leftMouseDown:
            return "leftMouseDown"
        case .leftMouseUp:
            return "leftMouseUp"
        case .rightMouseDown:
            return "rightMouseDown"
        case .rightMouseUp:
            return "rightMouseUp"
        case .mouseMoved:
            return "mouseMoved"
        case .leftMouseDragged:
            return "leftMouseDragged"
        case .rightMouseDragged:
            return "rightMouseDragged"
        case .mouseEntered:
            return "mouseEntered"
        case .mouseExited:
            return "mouseExited"
        case .keyDown:
            return "keyDown"
        case .keyUp:
            return "keyUp"
        case .flagsChanged:
            return "flagsChanged"
        case .appKitDefined:
            return "appKitDefined"
        case .systemDefined:
            return "systemDefined"
        case .applicationDefined:
            return "applicationDefined"
        case .periodic:
            return "periodic"
        case .cursorUpdate:
            return "cursorUpdate"
        case .scrollWheel:
            return "scrollWheel"
        case .tabletPoint:
            return "tabletPoint"
        case .tabletProximity:
            return "tabletProximity"
        case .otherMouseDown:
            return "otherMouseDown"
        case .otherMouseUp:
            return "otherMouseUp"
        case .otherMouseDragged:
            return "otherMouseDragged"
        case .gesture:
            return "gesture"
        case .magnify:
            return "magnify"
        case .swipe:
            return "swipe"
        case .rotate:
            return "rotate"
        case .beginGesture:
            return "beginGesture"
        case .endGesture:
            return "endGesture"
        case .smartMagnify:
            return "smartMagnify"
        case .quickLook:
            return "quickLook"
        case .pressure:
            return "pressure"
        case .directTouch:
            return "directTouch"
        case .changeMode:
            return "changeMode"
        @unknown default:
            return "unknown-key-\(rawValue)"
        }
    }
}
#endif
