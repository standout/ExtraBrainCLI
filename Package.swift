// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtraBrain",
    products: [
        .executable(
            name: "eb",
            targets: ["ExtraBrainCLI"]),
        .library(
            name: "ExtraBrain",
            targets: ["ExtraBrain"]),
    ],
    dependencies: [
        // Commander, makes documentation and routing of command line interfaces a
        // lot easier to build.
        // Doumentation: https://github.com/kylef/Commander
        .package(url: "git@github.com:kylef/Commander.git", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "ExtraBrain",
            dependencies: []),
        .testTarget(
            name: "ExtraBrainTests",
            dependencies: ["ExtraBrain"]),
        .target(
            name: "ExtraBrainCLI",
            dependencies: ["ExtraBrain", "Commander"]),
        .testTarget(
            name: "ExtraBrainCLITests",
            dependencies: ["ExtraBrainCLI"]),
    ]
)
