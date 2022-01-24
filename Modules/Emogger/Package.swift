// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Emogger",
    products: [
        .library(
            name: "Emogger",
            targets: ["Emogger"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Emogger",
            dependencies: []),
        .testTarget(
            name: "EmoggerTests",
            dependencies: ["Emogger"]),
    ]
)
