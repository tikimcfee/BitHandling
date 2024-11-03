//
//  FileBrowser+Event.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 5/24/22.
//

import Foundation

public enum SelectType {
    case toggle
    case addToWorld
    case removeFromWorld
}

public struct FileBrowserEvent {
    public let scope: FileBrowser.Scope
    public let action: SelectType
    
    public init(
        _ scope: FileBrowser.Scope,
        _ action: SelectType
    ) {
        self.scope = scope
        self.action = action
    }
}
