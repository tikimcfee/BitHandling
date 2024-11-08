import Foundation

#if os(OSX)
import AppKit
#endif


public typealias FileResult = Result<URL, FileError>
public typealias FileReceiver = (FileResult) -> Void

public typealias DirectoryResult = Result<Directory, FileError>
public typealias DirectoryReceiver = (DirectoryResult) -> Void

public extension DirectoryResult {
    var parent: URL? {
        if case let .success(url) = self { return url.parent }
        return nil
    }
    var children: [URL]? {
        if case let .success(url) = self { return url.fileUrls }
        return nil
    }
}

public struct Directory {
    let parent: URL
    let fileUrls: [URL]
}

public enum FileError: Error {
    case generic
    case noSwiftSource
}

public func showInFinder(url: URL?) {
    switch url {
#if os(OSX)
    case let .some(url) where url.isDirectory:
        NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: url.path)
    case let .some(url):
        NSWorkspace.shared.activateFileViewerSelecting([url])
#endif
    default:
        print("Cannot open url: \(url?.description ?? "<nil url>")")
    }
}

#if os(OSX)

public func openFile(_ receiver: @escaping FileReceiver) {
    DispatchQueue.main.async {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Choose a Swift source file to view"
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.canHide = true
        panel.begin { response in
            guard response == NSApplication.ModalResponse.OK,
                let fileUrl = panel.url else {
                receiver(.failure(.generic))
                return
            }
            receiver(.success(fileUrl))
        }
    }
}

public func selectDirectory(
    _ config: ((NSOpenPanel) -> Void)? = nil,
    _ receiver: @escaping DirectoryReceiver
) {
    DispatchQueue.main.async {
        let panel = NSOpenPanel()
        config?(panel)
        panel.nameFieldLabel = "Select source directory"
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canHide = true
        panel.begin { response in
            guard response == NSApplication.ModalResponse.OK,
                  let directoryUrl = panel.url else {
                      receiver(.failure(.generic))
                      return
                  }
            
            receiver(.success(
                Directory(
                    parent: directoryUrl,
                    fileUrls: []
                ))
            )
        }
    }
}


public func openDirectory(_ receiver: @escaping DirectoryReceiver) {
    DispatchQueue.main.async {
        let panel = NSOpenPanel()
        panel.nameFieldLabel = "Choose a directory to open"
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canHide = true
        panel.begin { response in
            guard response == NSApplication.ModalResponse.OK,
                  let directoryUrl = panel.url else {
                receiver(.failure(.generic))
                return
            }

            let fileURLs = try? FileManager.default.contentsOfDirectory(
                at: directoryUrl,
                includingPropertiesForKeys: nil,
                options: [.skipsSubdirectoryDescendants]
            )

            receiver(.success(
                Directory(
                    parent: directoryUrl,
                    fileUrls: fileURLs ?? []
                ))
            )
        }
    }
}
#elseif os(iOS)
public func openFile(_ receiver: @escaping FileReceiver) {
    print("Open file not implemented", #file)
}

public func openDirectory(_ receiver: @escaping DirectoryReceiver) {
    print("Open directory not implemented", #file)
}
#endif
