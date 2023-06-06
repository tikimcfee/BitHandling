//
//  RWLock.swift
//  SwiftConcurrentCollections
//
//  Created by Pete Prokop on 09/02/2020.
//  Copyright © 2020 Pete Prokop. All rights reserved.
//

import Foundation

public final class LockWrapper {
    private var lock = UnfairLock()
    
    public init() {
        
    }

    // MARK: Public
    public func writeLock() {
        lock.lock()
    }

    public func readLock() {
        lock.lock()
    }

    public func unlock() {
        lock.unlock()
    }
}

public final class UnfairLock: NSLocking {
    public init() {
        
    }
    
    private let unfairLock: UnsafeMutablePointer<os_unfair_lock_s> = {
        let pointer = UnsafeMutablePointer<os_unfair_lock_s>.allocate(capacity: 1)
        pointer.initialize(to: os_unfair_lock_s())
        return pointer
    }()
    
    deinit {
        unfairLock.deinitialize(count: 1)
        unfairLock.deallocate()
    }
    
    public func lock() {
        os_unfair_lock_lock(unfairLock)
    }
    
    public func tryLock() -> Bool {
        os_unfair_lock_trylock(unfairLock)
    }
    
    public func unlock() {
        os_unfair_lock_unlock(unfairLock)
    }
}

public extension UnfairLock {
    func withAcquiredLock(_ action: () -> Void) {
        lock()
        action()
        unlock()
    }
    
    func withAcquiredLock<T>(_ action: () -> T) -> T {
        lock()
        let result = action()
        unlock()
        return result
    }
}
