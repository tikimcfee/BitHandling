//
//  CharacterExtensions.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 8/26/22.
//

import Foundation

public class HashCache: LockingCache<Character, UInt64> {
    var reversed: [Value: Key] = [:]
    
    public override func make(_ key: Key) -> Value {
        let prime: UInt64 = 31;
        let result = key.unicodeScalars.reduce(into: 0) { hash, scalar in
            hash = (hash * prime + UInt64(scalar.value)) % 1_000_000
        }
        reversed[result] = key
        return result
    }
}

public let hashCache = HashCache()

public extension Character {
    var glyphComputeHash: UInt64 {
        hashCache[self]
    }
}

public extension UInt64 {
    var glyphComputeCharacter: Character? {
        hashCache.reversed[self]
    }
}
