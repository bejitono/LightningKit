// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LightningKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LightningKit",
            targets: ["LightningKit"]),
        .library(
            name: "LightningKitUI",
            targets: ["LightningKitUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.7.0"),
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "LightningKit",
            dependencies: ["LightningKitClient"]),
        .target(
            name: "LightningKitUI",
            dependencies: []),
         .target(
            name: "LightningKitClient",
            dependencies: ["SwiftProtobuf", "KeychainAccess", "Lndmobile"])
    ]
)
