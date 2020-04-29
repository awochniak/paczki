// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "allegro",
    products: [],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", from: "1.12.0")
    ],
    targets: []
)
