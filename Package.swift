// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SKOnboarding",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SKOnboarding",
            targets: ["SKOnboarding"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SKOnboarding",
            dependencies: []),
        .testTarget(
            name: "SKOnboardingTests",
            dependencies: ["SKOnboarding"]),
    ]
)
