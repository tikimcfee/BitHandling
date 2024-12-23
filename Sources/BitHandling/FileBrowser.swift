//
//  FileBrowser.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 11/3/21.
//

import Foundation
import Combine

public class FileBrowser: ObservableObject {
    @Published public var scopes: [Scope] = []
    @Published public var fileSelectionEvents: FileBrowserEvent?
    
    public init() {
        
    }
}

public extension FileBrowser {
    static var assumeAllFilesSupported: Bool {
        GlobalLiveConfig.store.preference.supportAllFiles
    }
    
    static var supportedTextExtensions: Set<String> {
        GlobalLiveConfig.store.preference.supportedFileExtensions
    }
    
    static var supportedColorizedExtensions: Set<String> {
        GlobalLiveConfig.store.preference.supportedColorizedExtensions
    }
    
    static var unsupportedExtensions: Set<String> {
        GlobalLiveConfig.unsupportedExtensions
    }
    
    // This is fragile. Both collapse/expand need to filter repeatedly.
    static func isFileObserved(_ path: URL) -> Bool {
        !path.lastPathComponent.starts(with: ".")
        && !isUnsupportedFileType(path)
    }
    
    static func isSupportedColorizedFileType(_ path: URL) -> Bool {
        Self.assumeAllFilesSupported
        || !path.isDirectory
        && supportedColorizedExtensions.contains(path.pathExtension)
    }
    
    static func isSupportedFileType(_ path: URL) -> Bool {
        Self.assumeAllFilesSupported
        || !path.isDirectory
        && supportedTextExtensions.contains(path.pathExtension)
    }
    
    static func isUnsupportedFileType(_ path: URL) -> Bool {
        unsupportedExtensions.contains(path.pathExtension)
    }
    
    static func isSwiftFile(_ path: URL) -> Bool {
        path.pathExtension == "swift"
    }
    
    static func directChildren(_ path: URL) -> [URL] {
        path.children(recursive: false).filter { isFileObserved($0) }
    }
    
    static func recursivePaths(_ path: URL) -> [URL] {
        path.children(recursive: true)
    }
    
    static func sortedFilesFirst(_ left: URL, _ right: URL) -> Bool {
        switch (left.isDirectory, right.isDirectory) {
        case (true, true): return left.path < right.path
        case (false, true): return true
        case (true, false): return false
        case (false, false): return left.path < right.path
        }
    }
}

public extension URL {
    // This is gross, but the scope must remain open for the duration of usage
    // since we actively read from arbitrary paths in the tree. Track to at least
    // have a record and descope if needed.
    private static var openScopedBookmarks = Set<URL>()
    private static var scopeCreationOptions: URL.BookmarkCreationOptions {
        #if os(macOS)
        [.withSecurityScope]
        #else
        []
        #endif
    }
    private static var scopeResolutionOptions: URL.BookmarkResolutionOptions {
        #if os(macOS)
        [.withSecurityScope]
        #else
        []
        #endif
    }
    private static func newOpenScope(_ url: URL) {
        if openScopedBookmarks.contains(url) {
            print("Warning, set already contains this url!")
        }
        openScopedBookmarks.insert(url)
        print("Scoped URL recorded: \(url)")
    }
    static func dumpAndDescopeAllKnownBookmarks() {
        openScopedBookmarks.forEach {
            print("Descoping: \($0)")
            $0.stopAccessingSecurityScopedResource()
        }
        openScopedBookmarks = []
    }
    
    func createDefaultBookmark() throws -> Data {
        try bookmarkData(
            options: Self.scopeCreationOptions,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
    }
    
    static func doWithScopedBookmark(
        _ data: Data,
        _ receiver: (URL) -> Void
    ) {
        do {
            var isStale = false
            let scopedBookmarkURL = try URL(
                resolvingBookmarkData: data,
                options: scopeResolutionOptions,
                relativeTo: nil,
                bookmarkDataIsStale: &isStale
            )
            if isStale {
                print("Stale bookmark found, must recreate")
            }
            guard scopedBookmarkURL.startAccessingSecurityScopedResource() else {
                print("Could not access security scope at \(self)")
                return
            }
            receiver(scopedBookmarkURL)
            newOpenScope(scopedBookmarkURL)
        } catch {
            print(error)
        }
    }
}

public extension URL {
    var isSupportedFileType: Bool {
        FileBrowser.isSupportedFileType(self)
    }
    
    var isColorizedFileType: Bool {
        FileBrowser.isSupportedColorizedFileType(self)
    }
}
    
public extension URL {
    private static let _fileManager = FileManager.default
    private var fileManager: FileManager { Self._fileManager }
    
    var isDirectory: Bool {
        if hasDirectoryPath { return true }
        let flags = try? resourceValues(forKeys: [.isDirectoryKey, .isPackageKey])
        return flags?.isDirectory ?? flags?.isPackage ?? false
    }
    
    var isRegularFile: Bool {
        (try? resourceValues(forKeys: [.isRegularFileKey]).isRegularFile) == true
    }
    
    var fileName: String { lastPathComponent }
    
    func isSiblingOf(_ otherURL: URL) -> Bool {
        deletingLastPathComponent() == otherURL.deletingLastPathComponent()
    }
    
    func children(recursive: Bool = false) -> [URL] {
        if recursive {
            return enumeratedChildren()
        } else {
            do {
                let found = try fileManager.contentsOfDirectory(
                    at: self,
                    includingPropertiesForKeys: [
                        .isDirectoryKey,
                        .isPackageKey,
//                        .isVolumeKey
                    ],
                    options: [.skipsHiddenFiles]
                )
                return found
            } catch {
                print("Failed to iterate children, recursive=\(recursive): ", error)
                return []
            }
        }
    }
    
    func filterdChildren(_ filter: (URL) -> Bool) -> [URL] {
        children()
            .filter(filter)
            .sorted(by: FileBrowser.sortedFilesFirst)
    }
    
    func enumeratedChildren() -> [URL] {
        guard let enumerator = fileManager
            .enumerator(
                at: self,
                includingPropertiesForKeys: [
                    .isDirectoryKey,
                    .isPackageKey,
//                    .isVolumeKey
                ],
                options: [.skipsHiddenFiles],
                errorHandler: { print($1, $0); return false }
            )
        else {
            print("\t\tCould not create enumerator for \(self)")
            return []
        }
        
        var result = [URL]()
        while let url = enumerator.nextObject() as? URL {
            let url = url.resolvingSymlinksInPath()
            let isReadableFile = FileBrowser.isFileObserved(url)
            if !isReadableFile {
                if url.isDirectory {
                    enumerator.skipDescendants()
                }
                continue
            }
            result.append(url)
        }
        return result.sorted(by: { $0.path.compare($1.path) == .orderedAscending  })
    }
}
