// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JumpingLoader",
    products: [
        .library(name: "JumpingLoader", targets: ["JumpingLoader"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "JumpingLoader", dependencies: [], exclude: ["../../Sample-Project/"]),
        .testTarget(name: "JumpingLoaderTests", dependencies: ["JumpingLoader"]),
    ]
)
