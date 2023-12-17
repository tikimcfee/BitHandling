//
//  GitHubClient.swift
//  LookAtThat_AppKit
//
//  Created by Ivan Lugo on 6/1/22.
//

import Foundation

public class GitHubClient {
//    public static let shared = GitHubClient()
    
    static let basePath = "https://api.github.com/"
    static let baseURL = URL(string: basePath)!
    private let session: URLSession
    
    public init(
        session: URLSession
    ) {
        self.session = session
    }
}

public extension GitHubClient {
    #if canImport(Zip)
    func fetch(
        endpoint: Endpoint
    ) -> URLSessionDownloadTask {
        switch endpoint {
        case .repositoryZip(_):
            let task = session.downloadTask(with: endpoint.apiUrl)
            return task
        }
    }
    
    func downloadAndUnzipRepository(
        owner: String,
        repositoryName: String,
        branchName: String,
        _ unzippedRepoReceiver: @escaping (Result<URL, Error>) -> Void
    ) -> URLSessionDownloadTask {
        let repoFileDownloadTarget = AppFiles.githubRepositoriesRoot
            .appendingPathComponent(repositoryName, isDirectory: true)
        
        let task = fetch(endpoint: .repositoryZip(
            RepositoryZipArgs(
                owner: owner,
                repo: repositoryName,
                branchRef: branchName,
                unzippedResultTargetUrl: repoFileDownloadTarget
            )
        ))
        task.resume()
        return task
    }
    #endif
}

public extension GitHubClient {
    enum ClientError: Swift.Error {
        case missingResultURL
    }
    
    struct RepositoryZipArgs {
        public let owner: String
        public let repo: String
        public let branchRef: String
        
        public let unzippedResultTargetUrl: URL
        
        public init(
            owner: String,
            repo: String,
            branchRef: String,
            unzippedResultTargetUrl: URL
        ) {
            self.owner = owner
            self.repo = repo
            self.branchRef = branchRef
            self.unzippedResultTargetUrl = unzippedResultTargetUrl
        }
    }
    
    enum Endpoint {
        case repositoryZip(RepositoryZipArgs)
        
        public var apiPath: String {
            switch self {
            case let .repositoryZip(args):
                return "repos/\(args.owner)/\(args.repo)/zipball/\(args.branchRef)"
            }
        }
        
        public var apiUrl: URL {
            GitHubClient.baseURL.appendingPathComponent(apiPath)
        }
    }
}
