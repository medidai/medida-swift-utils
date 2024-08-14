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
        .package(url: "git@github.com:DataDog/dd-sdk-ios.git", from: "2.15.0"),
    ],
    targets: [
        .target(
            name: "MedidaSwiftUtils",
            dependencies: [
                .product(name: "Datadog", package: "Datadog"),
            ]
        ),
        .testTarget(
            name: "MedidaSwiftUtilsTests",
            dependencies: [ "MedidaSwiftUtils" ]
        ),
    ]
)
