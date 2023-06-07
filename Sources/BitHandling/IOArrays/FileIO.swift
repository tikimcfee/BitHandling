//
//  FileIO.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 4/29/22.
//

import Foundation

public class AppendingStore {
    public let targetFile: URL
    
    public init(targetFile: URL) {
        self.targetFile = targetFile
    }
    
    public func cleanFile() {
        do {
            try FileManager.default.removeItem(at: targetFile)
            AppFiles.touch(in: targetFile)
        } catch {
            print("Failed to clean file", error)
        }
    }
    
    public func removeFile() {
        do {
            try FileManager.default.removeItem(at: targetFile)
        } catch {
            print("Failed to remove file", error)
        }
    }
    
    public func appendText(_ text: String, encoded encoding: String.Encoding = .utf8) {
        if let data = text.data(using: encoding) {
            do {
                try appendToFile(data)
            } catch {
                print("File append failed", error)
            }
        }
    }
    
    private func appendToFile(_ data: Data) throws {
        let handle = try FileHandle(forUpdating: targetFile)
        handle.seekToEndOfFile()
        handle.write(data)
        try handle.close()
    }
}
