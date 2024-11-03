//
//  CharacterExtensions.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 8/26/22.
//

import Foundation

class HashCache: LockingCache<Character, UInt64> {
    public override func make(_ key: Key) -> Value {
        let prime: UInt64 = 31;
        return key.unicodeScalars.reduce(into: 0) { hash, scalar in
            hash = (hash * prime + UInt64(scalar.value)) % 1_000_000
        }
    }
}
let hashCache = HashCache()

public extension Character {
    var glyphComputeHash: UInt64 {
        hashCache[self]
    }
}
