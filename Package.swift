// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtraBrain",
    products: [
        // The CLI for ExtraBrain.
        // NOTE: This is only nessecary becouse when tesing with xcode it doesn't build the actually "eb" executable.
        //       It builds the executable using only the target name instead...
        .executable(
            name: "ExtraBrainCLI",
            targets: ["ExtraBrainCLI"]),
        // The CLI for ExtraBrain again but compiled with a shorter name
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
        // The core application. Should include use cases, bussiness logic and bussiness objects
        .target(
            name: "ExtraBrain",
            dependencies: []),
        .testTarget(
            name: "ExtraBrainTests",
            dependencies: ["ExtraBrain"]),
        // Delivery mechanism for ExtraBrain in the command line
        .target(
            name: "ExtraBrainCLI",
            dependencies: ["ExtraBrain", "Commander"]),
        .testTarget(
            name: "ExtraBrainCLITests",
            dependencies: ["ExtraBrainCLI"]),
    ]
)
