//
//  WorkerPool.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 4/16/22.
//

import Foundation

public final class WorkerPool {
    
    public static let shared = WorkerPool()
    
    private lazy var serialWorker = DispatchQueue(
        label: "LugoWorkerPool-Serial-1",
        qos: .userInteractive
    )
    
    private lazy var concurrentWorker = DispatchQueue(
        label: "LugoWorkerPool-Concurrent-1",
        qos: .userInteractive,
        attributes: .concurrent
    )
    
    private init() {}
    
    public func nextWorker() -> DispatchQueue {
        return serialWorker
    }
    
    public func nextConcurrentWorker() -> DispatchQueue {
        return concurrentWorker
    }
    
    // TODO: - Yeah I just made things worse throwing queues at the problem.
    /// A single worker queue acting on all text data to dump directly into the GPU
    /// is just way faster. Easily multiple seconds across, and it's likely all the contention.
    /// Now all the performance cruft is in `render` because of the `update + render` pass, which is... lame.
    /// If `update` can happen JIT, lazily, and via cache, we should be good...
//    private lazy var workerIterator = allWorkers.makeIterator()
//    private lazy var concurrentWorkerIterator = concurrentWorkers.makeIterator()
//    private let workerCount = (ProcessInfo.processInfo.processorCount - 1)
//
//    public func nextWorker() -> DispatchQueue {
//        return workerIterator.next() ?? {
//            workerIterator = allWorkers.makeIterator()
//            let next = workerIterator.next()!
//            return next
//        }()
//    }
//    
//    public func nextConcurrentWorker() -> DispatchQueue {
//        return concurrentWorkerIterator.next() ?? {
//            concurrentWorkerIterator = concurrentWorkers.makeIterator()
//            let next = concurrentWorkerIterator.next()!
//            return next
//        }()
//    }
//    
//    private lazy var allWorkers =
//        (0..<3).map { DispatchQueue(
//            label: "LugoWorkerPool-Serial-\($0)",
//            qos: .userInitiated
//        )}
//    
//    private lazy var concurrentWorkers =
//        (0..<workerCount).map { DispatchQueue(
//            label: "LugoWorkerPool-Concur-\($0)",
//            qos: .userInitiated,
//            attributes: .concurrent
//        )}
}
