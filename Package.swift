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
        
    ],
    targets: [
        .target(
            name: "MedidaSwiftUtils",
            dependencies: [
                
            ]
        ),
        .testTarget(
            name: "MedidaSwiftUtilsTests",
            dependencies: [ "MedidaSwiftUtils" ]
        ),
    ]
)
