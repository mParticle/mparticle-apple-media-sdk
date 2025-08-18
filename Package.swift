// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "mParticle-Apple-Media-SDK",
    platforms: [ .iOS(.v9), .tvOS(.v9) ],
    products: [
        .library(
            name: "mParticle-Apple-Media-SDK",
            targets: ["mParticle-Apple-Media-SDK"]),
        .library(
            name: "mParticle-Apple-Media-SDK-NoLocation",
            targets: ["mParticle-Apple-Media-SDK-NoLocation"]),
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
                .product(
                   name: "mParticle-Apple-SDK",
                   package: "mParticle-Apple-SDK"
               )
            ],
            path: "mParticle-Apple-Media-SDK",
            exclude: ["Info.plist"],
            resources: [.process("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "."
        ),
        .target(
            name: "mParticle-Apple-Media-SDK-NoLocation",
            dependencies: [
                .product(
                   name: "mParticle-Apple-SDK-NoLocation",
                   package: "mParticle-Apple-SDK"
               ),
            ],
            path: "mParticle-Apple-Media-SDK-NoLocation",
            exclude: ["Info.plist"],
            resources: [.process("PrivacyInfo.xcprivacy")],
            publicHeadersPath: ".",
            cSettings: [.define("MP_NO_LOCATION")]
        )
    ]
)
