// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "mParticle-Apple-Media-SDK",
    platforms: [.iOS(.v15), .tvOS(.v15)],
    products: [
        .library(
            name: "mParticle-Apple-Media-SDK",
            targets: ["mParticle-Apple-Media-SDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/mParticle/mparticle-apple-sdk",
                 branch: "main")
    ],
    targets: [
        .target(
            name: "mParticle-Apple-Media-SDK",
            dependencies: [
                .product(name: "mParticle-Apple-SDK",
                         package: "mparticle-apple-sdk")
            ],
            path: "mParticle-Apple-Media-SDK",
            exclude: ["Info.plist"],
            resources: [.process("PrivacyInfo.xcprivacy")],
            publicHeadersPath: "."
        )
    ]
)
