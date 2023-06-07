// Originally from https://gist.github.com/CanTheAlmighty/70b3bf66eb1f2a5cee28

public class ConcurrentBiMap<Key: Hashable, Value: Hashable>: ExpressibleByDictionaryLiteral {
    public typealias Forward = ConcurrentDictionary<Key, Value>
    public typealias Backward = ConcurrentDictionary<Value, Key>
    public private(set) var keysToValues = Forward()
    public private(set) var valuesToKeys = Backward()
    
    // MARK: - Initializers
    
    public init(forward: Forward) {
        let newBackward = Backward()
        forward.directCopy().forEach { pair in
            newBackward[pair.value] = pair.key
        }
        self.keysToValues = forward
        self.valuesToKeys = newBackward
    }
    
    public init(backward: Backward) {
        let newForward = Forward()
        backward.directCopy().forEach { pair in
            newForward[pair.value] = pair.key
        }
        self.keysToValues = newForward
        self.valuesToKeys = backward
    }
    
    public required init(dictionaryLiteral elements: (Key, Value)...) {
        for keyValuePair in elements {
            keysToValues[keyValuePair.0] = keyValuePair.1
            valuesToKeys[keyValuePair.1] = keyValuePair.0
        }
    }
    
    public init() { }
    
    // MARK: - Subscripts
    
    public subscript(key: Key) -> Value? {
        get {
            return keysToValues[key]
        }
        
        set {
            if let toRemove = keysToValues[key] {
                valuesToKeys[toRemove] = newValue == nil ? nil : key
            } else if let newValue = newValue {
                valuesToKeys[newValue] = key
            }
            keysToValues[key] = newValue
        }
    }
    
    public subscript(valueAsKey: Value) -> Key? {
        get {
            return valuesToKeys[valueAsKey]
        }
        
        set {
            if let keyAsKeyToUpdate = valuesToKeys[valueAsKey] {
                keysToValues[keyAsKeyToUpdate] = newValue == nil ? nil : valueAsKey
            } else if let newValue = newValue {
                keysToValues[newValue] = valueAsKey
            }
            valuesToKeys[valueAsKey] = newValue
        }
    }

}

public struct BiMap<Key: Hashable, Value: Hashable>: ExpressibleByDictionaryLiteral {
    public var keysToValues: [Key : Value] = [:]
    public var valuesToKeys: [Value : Key] = [:]

    // MARK: - Initializers

    public init(forward: [Key: Value]) {
        var newBackward: [Value: Key] = [:]

        for (key,value) in forward {
            newBackward[value] = key
        }

        self.keysToValues = forward
        self.valuesToKeys = newBackward
    }

    public init(backward: [Value: Key]) {
        var newForward: [Key: Value] = [:]

        for (key, value) in backward {
            newForward[value] = key
        }

        self.keysToValues = newForward
        self.valuesToKeys = backward
    }

    public init(dictionaryLiteral elements: (Key, Value)...) {
        for keyValuePair in elements {
            keysToValues[keyValuePair.0] = keyValuePair.1
            valuesToKeys[keyValuePair.1] = keyValuePair.0
        }
    }

    public init() { }

    // MARK: - Subscripts

    public subscript(key : Key) -> Value? {
        get {
            return keysToValues[key]
        }

        set {
            if let toRemove = keysToValues[key] {
                valuesToKeys[toRemove] = newValue == nil ? nil : key
            } else if let newValue = newValue {
                valuesToKeys[newValue] = key
            }
            keysToValues[key] = newValue
        }
    }

    public subscript(valueAsKey : Value) -> Key? {
        get {
            return valuesToKeys[valueAsKey]
        }

        set {
            if let keyAsKeyToUpdate = valuesToKeys[valueAsKey] {
                keysToValues[keyAsKeyToUpdate] = newValue == nil ? nil : valueAsKey
            } else if let newValue = newValue {
                keysToValues[newValue] = valueAsKey
            }
            valuesToKeys[valueAsKey] = newValue
        }
    }
}
