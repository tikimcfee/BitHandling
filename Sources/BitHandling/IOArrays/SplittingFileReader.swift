//
//  SplittingFileReader.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 5/1/22.
//
//  With many thanks to the wonderful experimentalists here:
//  https://forums.swift.org/t/difficulties-with-efficient-large-file-parsing/23660
//  https://forums.swift.org/t/what-s-the-recommended-way-to-memory-map-a-file/19113/6
//  https://forums.swift.org/t/reading-large-files-fast-and-memory-efficient/37704/1
//

import Foundation

public class SplittingFileReader {
    public typealias Receiver = (String, inout Bool) -> Void
    
    private(set) lazy var lazyLoadSplits: [String] = doSplit()
    
    public let targetURL: URL
    
    public init(targetURL: URL) {
        self.targetURL = targetURL
    }
    
    public func cancellableRead(_ receiver: Receiver) {
//        doSplit(receiver: receiver)
        doSplitNSData(receiver: receiver)
    }
    
    public func asyncLineStream() -> AsyncStream<String> {
        doIterativeSplitNSData()
    }
}

private extension SplittingFileReader {
    static private let asciiSeparator = UInt8(ascii: "\n")
    
    func doSplit() -> [String] {
        getDataBlock().withUnsafeBytes(Self.immediateSplitBuffer)
    }
    
    func doSplit(receiver: Receiver) {
        getDataBlock().withUnsafeBytes {
            Self.cancellableSplitBuffer($0, to: receiver)
        }
    }
    
    func doSplitNSData(receiver: Receiver) {
        do {
//            return try Data(contentsOf: targetURL, options: .alwaysMapped)
            let data = try NSData(contentsOf: targetURL, options: .alwaysMapped)
            let pointer = UnsafeRawBufferPointer(start: data.bytes, count: data.count)
            Self.cancellableSplitBuffer(pointer, to: receiver)
        } catch {
            print("Failed to read \(targetURL) for autosplit, returning empty data")
        }
    }
    
    func doIterativeSplitNSData() -> AsyncStream<String> {
        let data: NSData
        do {
            data = try NSData(contentsOf: targetURL, options: .alwaysMapped)
        } catch {
            data = NSData()
            print("Failed to read \(targetURL) for autosplit, returning empty data")
        }
        
        let pointer = UnsafeRawBufferPointer(start: data.bytes, count: data.count)
        return Self.iterativeSplitBuffer(pointer)
    }
    
    func getDataBlock() -> Data {
        do {
            return try Data(contentsOf: targetURL, options: .mappedIfSafe)
        } catch {
            print("Failed to read \(targetURL) for autosplit, returning empty data")
            return Data()
        }
    }
    
    static func cancellableSplitBuffer(_ body: UnsafeRawBufferPointer, to receiver: Receiver) {
        var (start, stop, stopProcessing) = (0, 0, false)
        for pointerElement in body where !stopProcessing {
            if pointerElement == asciiSeparator {
                let slice = Slice<UnsafeRawBufferPointer>(base: body, bounds: start..<stop)
                let decoded = decodeStringFromSlice(slice)
                receiver(decoded, &stopProcessing)
                stop += 1
                start = stop
            } else {
                stop += 1
            }
        }
    }
    
    static func iterativeSplitBuffer(_ body: UnsafeRawBufferPointer) -> AsyncStream<String> {
        AsyncStream<String> { continuation in
            var (start, stop) = (0, 0)
            for pointerElement in body {
                if pointerElement == asciiSeparator {
                    let slice = Slice<UnsafeRawBufferPointer>(base: body, bounds: start..<stop)
                    let decoded = decodeStringFromSlice(slice)
                    continuation.yield(decoded)
                    
                    stop += 1
                    start = stop
                } else {
                    stop += 1
                }
            }
            continuation.finish()
        }
    }
    
    static func immediateSplitBuffer(_ body: UnsafeRawBufferPointer) -> [String] {
        body.split(separator: asciiSeparator)
            .map(decodeStringFromSlice)
    }
    
    static func decodeStringFromSlice(_ slice: Slice<UnsafeRawBufferPointer>) -> String {
        String(decoding: UnsafeRawBufferPointer(rebasing: slice), as: UTF8.self)
    }
}
