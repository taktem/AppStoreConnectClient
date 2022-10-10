// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppStoreConnectClient",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "AppStoreConnectClient",
            targets: ["AppStoreConnectClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/jwt-kit.git", "4.0.0" ..< "5.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "AppStoreConnectClient",
            dependencies: [
                .product(name: "JWTKit", package: "jwt-kit"),
            ]),
        .testTarget(
            name: "AppStoreConnectClientTests",
            dependencies: ["AppStoreConnectClient"]),
    ]
)
