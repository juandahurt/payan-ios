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
        .package(url: "https://github.com/Nike-Inc/Willow.git", from: "5.0.0")
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
