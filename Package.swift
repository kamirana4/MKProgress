// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MKProgress",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MKProgress",
            targets: ["MKProgress"])
    ],
    targets: [
        .target(
            name: "MKProgress",
            path: "MKProgress"
        )
    ]
)

