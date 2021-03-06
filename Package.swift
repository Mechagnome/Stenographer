// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "Stenographer",
    platforms: [.macOS(.v11), .iOS(.v15), .watchOS(.v8), .tvOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Stenographer",
            targets: ["Stenographer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Mechagnome/Alliances", from: "1.0.0"),
        .package(url: "https://github.com/linhay/Stem.git", from: "1.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Stenographer",
            dependencies: [
                .product(name: "Stem", package: "Stem"),
                .product(name: "Alliances", package: "Alliances")
            ]),
        .testTarget(
            name: "StenographerTests",
            dependencies: ["Stenographer"]),
    ]
)
