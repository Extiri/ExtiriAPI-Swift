// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtiriAPI",
	platforms: [
		.macOS(.v10_12),
		.iOS(.v10)
	],
    products: [
        .library(
            name: "ExtiriAPI",
			targets: ["ExtiriAPI"])
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "ExtiriAPI",
            dependencies: []),
        .testTarget(
            name: "ExtiriAPITests",
            dependencies: ["ExtiriAPI"]),
    ]
)
