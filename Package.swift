// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppStrings",
    platforms: [.iOS(.v18), .macOS(.v15), .tvOS(.v18), .watchOS(.v11), .visionOS(.v2)],
    products: [
        .library(name: "AppStrings", targets: ["AppStrings"])
    ],
    targets: [
        .target(name: "AppStrings"),
        .testTarget(name: "AppStringsTests", dependencies: ["AppStrings"])
    ],
    swiftLanguageModes: [.v6]
)
