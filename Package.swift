// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Home",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Home",
            targets: ["Home"]
        )
    ],
    dependencies: [
//        .package(path: "../Common"),
//        .package(path: "../Login")
    ],
    targets: [
        .target(
            name: "Home",
            dependencies: [
//                .product(name: "Common", package: "Common"),
//                .product(name: "Login", package: "Login")
            ],
            path: "Home"
        )
    ]
)
