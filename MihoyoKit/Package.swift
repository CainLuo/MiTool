// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MiHoYoKit",
    platforms: [.macOS(.v13), .iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MiHoYoKit",
            targets: ["MiHoYoKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", .upToNextMinor(from: "4.2.0")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", from: "1.8.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MiHoYoKit", dependencies: ["Alamofire", "ObjectMapper", "CryptoSwift"]),
        .testTarget(
            name: "MiHoYoKitTests",
            dependencies: ["MiHoYoKit"]),
    ]
)
