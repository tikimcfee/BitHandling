import Foundation

// Returns reads immediately, and if no value exists, locks dictionary write
// and creates a new object from the given builder. Passed map to allow additional
// modifications during critical section
public protocol CacheBuilder {
    associatedtype Key: Hashable
    associatedtype Value
    func make(_ key: Key) -> Value
}

open class LockingCache<Key: Hashable, Value>: CacheBuilder {
    
    private var cache = ConcurrentDictionary<Key, Value>()
    
    public init() {
        /* Maybe accept a cache instance.. or just use an Actor <3 */
    }

    open func make(_ key: Key) -> Value {
        fatalError("LockingCache subscript defaults to `make()`; implement this in [\(type(of: self))].")
    }

    public subscript(key: Key) -> Value {
        get { lockAndMake(key: key) }
		set { lockAndSet(key: key, value: newValue) }
    }
    
    public func isEmpty() -> Bool {
        cache.isEmpty
    }
        
    public func doOnEach(_ action: (Key, Value) -> Void) {
        var keys = cache.keys.makeIterator()
        var values = cache.values.makeIterator()
        while let key = keys.next(),
              let value = values.next() {
            action(key, value)
        }
    }
    
    public func doOnEachThrowing(_ action: (Key, Value) throws -> Void) rethrows {
        var keys = cache.keys.makeIterator()
        var values = cache.values.makeIterator()
        while let key = keys.next(),
              let value = values.next() {
            try action(key, value)
        }
    }
	
	private func lockAndSet(key: Key, value: Value) {
		cache[key] = value
	}
    
    private func lockAndMake(key: Key) -> Value {
        if let cached = cache[key] {
            return cached
        }
        
        let new = make(key)
        cache[key] = new

        return new
    }
}
