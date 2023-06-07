//
//  FileBackedArray.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 5/1/22.
//

import Foundation

// MARK: - String->UUID indexed mapping


typealias CharType = UInt8

public struct FileUUIDArray: RandomAccessCollection {
    let source: FileBlockStringArray
    
    public var startIndex: Int { source.startIndex }
    public var endIndex: Int { source.endIndex }
    
    init(source: FileBlockStringArray) {
        self.source = source
    }
    
    public subscript(position: Int) -> UUID? {
        return UUID(uuidString: source[position])
    }
}

public extension FileUUIDArray {
    private static let UUID_LENGTH = 36
    
    static func from(fileURL: URL) throws -> FileUUIDArray {
        let elementPointer = try MappedElementPointer<CharType>(file: fileURL)
        let source = FileBlockStringArray(base: elementPointer, lineLength: UUID_LENGTH)
        return FileUUIDArray(source: source)
    }
}

// MARK: - String file array


public struct FileBlockStringArray: RandomAccessCollection {
    var base: MappedElementPointer<CharType>
    let lineLength: Int
    
    public var startIndex: Int { 0 }
    public var endIndex: Int { base.backingPointer.count / lineLength }
    
    public var bufferPointer: UnsafeRawBufferPointer { UnsafeRawBufferPointer(base.backingPointer) }
    
    public subscript(position: Int) -> String {
        let start = position * lineLength
        let end = start + lineLength
        
        let computedSlice = Slice<UnsafeRawBufferPointer>(base: bufferPointer, bounds: start..<end)
        // todo: support time stamps/meta with some kind of key function
        let decoded = String(decoding: computedSlice, as: UTF8.self)
        return decoded
    }
}

// MARK: - Pointer container


public class MappedElementPointer<Element> {
    public enum Error: Swift.Error { case mmapError(Int32) }
    
    public let backingPointer: UnsafeBufferPointer<Element>
    
    public init(file: URL) throws {
        self.backingPointer = try Self.bufferPointer(from: file)
    }
    
    deinit {
        let buffer = UnsafeMutableRawBufferPointer(mutating: UnsafeRawBufferPointer(backingPointer))
        munmap(buffer.baseAddress, buffer.count)
    }
}

//MARK: - File loading


private extension MappedElementPointer {
    static func bufferPointer(from fileURL: URL) throws -> UnsafeBufferPointer<Element> {
        let fileHandle = try FileHandle(forReadingFrom: fileURL)
        fileHandle.seekToEndOfFile()
        
        let fileLength = Int(fileHandle.offsetInFile)
        let mmapPointer = try Self.doMMAP(fileLength, fileHandle)
        return UnsafeRawBufferPointer(start: mmapPointer, count: fileLength).bindMemory(to: Element.self)
    }
    
    static func doMMAP(_ length: Int, _ fileHandle: FileHandle) throws -> UnsafeMutableRawPointer {
        //    https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/mmap.2.html
        //        RETURN VALUES
        //        Upon successful completion, mmap returns a pointer to the mapped region.
        //        Otherwise, a value of -1 is returned and errno is set to indicate the
        //        error.
        let pointerOrError = mmap(
            nil,
            length,
            PROT_READ,
            MAP_PRIVATE | MAP_FILE,
            fileHandle.fileDescriptor,
            0
        )
        switch pointerOrError {
        case .some(let pointer):
            return pointer
        case .none:
            let errnoCurrent = errno
            throw Error.mmapError(errnoCurrent)
        }
    }
}
