// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "SecureNetworking",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SecureNetworking",
            targets: ["SecureNetworking"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SecureNetworking",
            dependencies: []),
        .testTarget(
            name: "SecureNetworkingTests",
            dependencies: ["SecureNetworking"]),
    ]
) 