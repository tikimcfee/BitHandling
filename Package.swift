// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BitHandling",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BitHandling",
            targets: ["BitHandling"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", exact: .init(1, 0, 4)),
        .package(url: "https://github.com/marmelroy/Zip.git", from: "2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BitHandling",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
                .product(name: "Zip", package: "Zip")
            ]
        ),
        .testTarget(
            name: "BitHandlingTests",
            dependencies: ["BitHandling"]),
    ]
)
