//
//  Collections+Extensions.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 9/30/22.
//

import Foundation
import OrderedCollections

public enum ToggleResult {
    case addedToSet, removedFromSet
}

public protocol Toggleable {
    associatedtype Element
    
    mutating func toggle(_ element: Element) -> ToggleResult
    
    func contains(_ element: Element) -> Bool
    
    @discardableResult
    mutating func remove(_ element: Element) -> Element?

    @discardableResult
    mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element)
}

extension Toggleable {
    
    @discardableResult
    public mutating func toggle(_ toggled: Element) -> ToggleResult {
        if contains(toggled) {
            remove(toggled)
            return .removedFromSet
        } else {
            insert(toggled)
            return .addedToSet
        }
    }
}

extension Set: Toggleable { }
extension OrderedSet: Toggleable {
    public mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        let result = insert(newMember, at: endIndex)
        return (result.inserted, newMember)
    }
}
