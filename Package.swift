// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "allegro",
    products: [
        .library(
            name: "allegro",
            targets: ["paczki"])
        ],
    dependencies: [],
    targets: [
        .target(
            name: “paczki”,
            dependencies: []),
    ]
)



