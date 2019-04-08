// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "workspace",
    dependencies: [
        .package(url: "https://github.com/oarrabi/Guaka.git", from: "0.3.1"),
        .Package(url: "https://github.com/stencilproject/Stencil.git", majorVersion: 0, minor: 13),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "workspace",
            dependencies: ["Guaka", "Stencil"]),
        .testTarget(
            name: "workspaceTests",
            dependencies: ["workspace"]),
    ]
)
