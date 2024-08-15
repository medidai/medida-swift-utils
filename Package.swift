// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MedidaSwiftUtils",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MedidaSwiftUtils",
            targets: [ "MedidaSwiftUtils" ]
        ),
    ],
    dependencies: [
        .package(url: "git@github.com:DataDog/dd-sdk-ios.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(
            name: "MedidaSwiftUtils",
            dependencies: [
                .product(name: "DatadogCore", package: "dd-sdk-ios"),
                .product(name: "DatadogObjc", package: "dd-sdk-ios"),
                .product(name: "DatadogLogs", package: "dd-sdk-ios"),
                .product(name: "DatadogTrace", package: "dd-sdk-ios"),
                .product(name: "DatadogRUM", package: "dd-sdk-ios"),
                .product(name: "DatadogSessionReplay", package: "dd-sdk-ios"),
                .product(name: "DatadogCrashReporting", package: "dd-sdk-ios"),
                .product(name: "DatadogWebViewTracking", package: "dd-sdk-ios"),
            ]
        ),
        .testTarget(
            name: "MedidaSwiftUtilsTests",
            dependencies: [ "MedidaSwiftUtils" ]
        ),
    ]
)
