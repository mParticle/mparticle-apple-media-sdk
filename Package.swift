// swift-tools-version:5.3

import PackageDescription

#if swift(>=5.3)
let ios = SupportedPlatform.iOS(.v9)
#else
let ios = SupportedPlatform.iOS(.v8)
#endif

let package = Package(
    name: "mParticle-Apple-Media-SDK",
    platforms: [ ios, .tvOS(.v9) ],
    products: [
        .library(
            name: "mParticle-Apple-Media-SDK",
            targets: ["mParticle-Apple-Media-SDK"]),
    ],
    dependencies: [
        .package(name: "mParticle-Apple-SDK",
            url: "https://github.com/mParticle/mparticle-apple-sdk",
            .upToNextMajor(from: "8.0.0")),
    ],
    targets: [
        .target(
        name: "mParticle-Apple-Media-SDK",
        dependencies: [
            "mParticle-Apple-SDK"
        ],
        path: "mParticle-Apple-Media-SDK",
        cSettings: [
            CSetting.headerSearchPath("./**"),
            .define("NS_BLOCK_ASSERTIONS", to: "1", .when(configuration: .release))
        ]),
    ]
)
