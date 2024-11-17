//
//  FlatFilePreference.swift
//  BitHandling
//
//  Created by Ivan Lugo on 11/16/24.
//


import Foundation
import AppKit
import SwiftUI

public protocol FlatFilePreference: Codable {
    var persistencePath: URL { get }
    init()
}

public extension FlatFilePreference {
    func saveToFile() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: persistencePath)
        } catch {
            print("- Failed to save \(Self.self). Target: \(persistencePath)")
            print(error)
        }
    }
    
    mutating func loadFromFile() {
        do {
            let data = try Data(contentsOf: persistencePath)
            guard data.count > 0 else {
                print("- No file found \(Self.self). Not resetting: \(persistencePath)")
                return
            }
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            print("Failed to decode \(Self.self). Not resetting: \(persistencePath). Error: ", error)
            return
        }
    }
}

public struct FlatFilePreferenceStore<T: FlatFilePreference> {
    public var preference: T {
        didSet {
            preference.saveToFile()
        }
    }
    
    public init(_ preference: T) {
        self.preference = preference
        self.preference.loadFromFile()
    }
}
