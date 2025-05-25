// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shared-frameworks",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "PersistenceCore", targets: ["PersistenceCore"]),
        .library(name: "SharedExtensions", targets: ["SharedExtensions"]),
        .library(name: "SharedProtocolsAndModels", targets: ["SharedProtocolsAndModels"]),
        .library(name: "Logger", targets: ["Logger"])
    ],
    targets: [

        // MARK: - PersistenceCore

        .target(
            name: "PersistenceCore",
            dependencies: [
                .target(name: "Logger")
            ]
        ),

        // MARK: - SharedExtensions

        .target(name: "SharedExtensions"),

        // MARK: - SharedProtocolsAndModels

        .target(name: "SharedProtocolsAndModels"),

        // MARK: - Logger

        .target(
            name: "Logger"
        )
    ]
)
