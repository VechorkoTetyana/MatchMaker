// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
        .library(
            name: "MatchMakerAuthentication",
            targets: ["MatchMakerAuthentication"]),
        .library(
            name: "MatchMakerLogin",
            targets: ["MatchMakerLogin"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.29.0"),
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "DesignSystem"),
        .target(
            name: "MatchMakerAuthentication",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]
        ),
        
        .target(
            name: "MatchMakerLogin",
            dependencies: [
            "MatchMakerAuthentication",
            "DesignSystem",
            "PhoneNumberKit",
            "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
