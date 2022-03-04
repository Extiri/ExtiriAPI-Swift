// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BackendMiddleware",
	platforms: [
		.macOS(.v10_12)
	],
    products: [
        .library(
            name: "BackendMiddleware",
            targets: ["BackendMiddleware"])
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "BackendMiddleware",
            dependencies: []),
        .testTarget(
            name: "BackendMiddlewareTests",
            dependencies: ["BackendMiddleware"]),
    ]
)
