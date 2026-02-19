// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shared-frameworks",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "Coordinator", targets: ["Coordinator"]),
        .library(name: "PersistenceCore", targets: ["PersistenceCore"]),
        .library(name: "SharedExtensions", targets: ["SharedExtensions"]),
        .library(name: "SharedProtocolsAndModels", targets: ["SharedProtocolsAndModels"]),
    ],
    targets: [

        // MARK: - Coordinator

        .target(
            name: "Coordinator",
            exclude: ["CLAUDE.md"]
        ),

        // MARK: - PersistenceCore

        .target(
            name: "PersistenceCore",
            exclude: ["CLAUDE.md"]
        ),

        // MARK: - SharedExtensions

        .target(
            name: "SharedExtensions",
            exclude: ["CLAUDE.md"]
        ),
        .testTarget(
            name: "SharedExtensionsTests",
            dependencies: ["SharedExtensions"]
        ),

        // MARK: - SharedProtocolsAndModels

        .target(
            name: "SharedProtocolsAndModels",
            exclude: ["CLAUDE.md"]
        ),
    ]
)
