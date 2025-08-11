// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "mParticle-Apple-Media-SDK",
    platforms: [ .iOS(.v9), .tvOS(.v9) ],
    products: [
        .library(
            name: "mParticle-Apple-Media-SDK",
            targets: ["mParticle-Apple-Media-SDK"]),
    ],
    dependencies: [
        .package(name: "mParticle-Apple-SDK",
            url: "https://github.com/mParticle/mparticle-apple-sdk",
            .upToNextMajor(from: "8.22.0")),
    ],
    targets: [
        .target(
            name: "mParticle-Apple-Media-SDK",
            dependencies: [
                "mParticle-Apple-SDK"
            ],
            path: "mParticle-Apple-Media-SDK",
            exclude: ["Info.plist"],
            resources: [.process("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "."
        )
    ]
)
