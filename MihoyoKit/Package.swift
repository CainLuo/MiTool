// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MihoyoKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MihoyoKit",
            targets: ["MihoyoKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMajor(from: "4.2.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MihoyoKit"),
        .testTarget(
            name: "MihoyoKitTests",
            dependencies: ["MihoyoKit"]),
    ]
)
