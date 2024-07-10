// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
        .library(
            name: "MatchMakerLogin",
            targets: ["MatchMakerLogin"]),
    ],
    dependencies: [
       
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "DesignSystem"),
        
        .target(
            name: "MatchMakerLogin",
            dependencies: [
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
