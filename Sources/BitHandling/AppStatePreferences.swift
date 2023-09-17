//
//  AppStatePreferences.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 5/26/22.
//

import Foundation

public class AppStatePreferences {
    private let store = UserDefaults(suiteName: "AppStatePreferences")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    public static let shared = AppStatePreferences()
    
    public enum Key: RawRepresentable {
        public typealias RawValue = String
        
        case panelStates
        case panelSections
        
        case lastScope
        case securedScopeData
        case custom(name: String)
        
        public init?(rawValue: String) {
            switch rawValue {
            case "panelStates": self = .panelStates
            case "panelSections": self = .panelSections
            case "lastScope": self = .lastScope
            case "securedScopeData": self = .securedScopeData
            default: self = .custom(name: rawValue)
            }
        }
        
        public var rawValue: String {
            switch self {
            case .lastScope: return "lastScope"
            case .panelStates: return "panelStates"
            case .panelSections: return "panelSections"
            case .securedScopeData: return "securedScopeData"
            case .custom(let x): return x
            }
        }
    }
    
    public var securedScopeData: PeristedSecureScope? {
        get { getPersistedSecureScope() }
        set { setPersistedSecureScope(newValue) }
    }
    
    public func getCustom<T: Codable>(name: String, makeDefault: () -> T) -> T {
        let key = Key.custom(name: name)
        if let state: T = _getEncoded(key) {
            return state
        }
        let state = makeDefault()
        _setEncoded(state, key)
        return state
    }
    
    public func setCustom<T: Codable>(name: String, value: T) {
        let key = Key.custom(name: name)
        _setEncoded(value, key)
    }
}

public typealias PeristedSecureScope = (FileBrowser.Scope, Data)

private extension AppStatePreferences {
    func getPersistedSecureScope() -> PeristedSecureScope? {
        guard let scope: FileBrowser.Scope = _getEncoded(.lastScope),
              let data: Data = _getRaw(.securedScopeData)
        else { return nil }
        return (scope, data)
    }
    
    func setPersistedSecureScope(_ newValue: PeristedSecureScope?) {
        _setEncoded(newValue?.0, .lastScope)
        _setRaw(newValue?.1, .securedScopeData)
    }
}

public extension AppStatePreferences {
    func _setEncoded<T: Codable>(_ any: T?, _ key: Key) {
        print(">>Updating Encoded preference '\(key)'")
        store?.set(try? encoder.encode(any), forKey: key.rawValue)
    }
    
    func _getEncoded<T: Codable>(_ key: Key) -> T? {
        guard let encoded = store?.object(forKey: key.rawValue) as? Data else { return nil }
        return try? decoder.decode(T.self, from: encoded)
    }
    
    func _setRaw<T: Codable>(_ any: T?, _ key: Key) {
        print(">> Updating Raw preference '\(key)'")
        store?.set(any, forKey: key.rawValue)
    }
    
    func _getRaw<T: Codable>(_ key: Key) -> T? {
        store?.object(forKey: key.rawValue) as? T
    }
}

