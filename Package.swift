// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "shared-frameworks",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "PersistenceCore", targets: ["PersistenceCore"]),
        .library(name: "SharedExtensions", targets: ["SharedExtensions"]),
        .library(name: "SharedProtocolsAndModels", targets: ["SharedProtocolsAndModels"]),
        .library(name: "SharedRouter", targets: ["SharedRouter"]),
        .library(name: "UIComponents", targets: ["UIComponents"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", exact: "5.7.0"),
        .package(url: "https://github.com/ekazaev/route-composer.git", exact: "2.10.5"),
        .package(url: "https://github.com/CocoaLumberjack/CocoaLumberjack.git", exact: "3.8.2"),
    ],
    targets: [
        // MARK: - PersistenceCore

        .target(
            name: "PersistenceCore",
            dependencies: [
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack")
            ]
        ),

        // MARK: - SharedExtensions

        .target(name: "SharedExtensions"),

        // MARK: - SharedProtocolsAndModels

        .target(name: "SharedProtocolsAndModels"),

        // MARK: - SharedRouter

        .target(
            name: "SharedRouter",
            dependencies: [
                .product(name: "RouteComposer", package: "route-composer"),
                .product(name: "CocoaLumberjack", package: "CocoaLumberjack")
            ]
        ),

        // MARK: - UIComponents

        .target(
            name: "UIComponents",
            dependencies: [
                .product(name: "SnapKit", package: "SnapKit")
            ]
        )
    ]
)
