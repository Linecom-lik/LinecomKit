// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LinecomKit",
    platforms: [
        .iOS(.v15), .watchOS(.v9), .macOS(.v11), .tvOS(.v16)
    ],
    products: [
        .library(
            name: "LinecomKit",
            targets: ["LinecomKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.8.1"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "LinecomKit",
            dependencies: [
                "Alamofire",
                "SwiftyJSON"
            ]
        )
    ]
)
