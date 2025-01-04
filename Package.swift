// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Interpolations",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "Interpolations",
            targets: ["Interpolations"]),
    ],
    targets: [
        .target(
            name: "Interpolations"),
        .testTarget(
            name: "InterpolationsTests",
            dependencies: ["Interpolations"]
        ),
    ]
)
