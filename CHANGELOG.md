<!-- markdownlint-disable MD024 -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/2.0.0.html).

## [Unreleased]

### Fixed

- Correct the Swift Package Manager minimum platform to iOS/tvOS 15.6 so it matches the Core SDK requirement ([#38](https://github.com/mParticle/mparticle-apple-media-sdk/pull/38))

## [2.0.0] - 2026-04-10

### Breaking Changes

- **iOS / tvOS 15.6 minimum**: Deployment target raised from iOS/tvOS 12.0 to 15.6. Apps targeting below 15.6 must remain on v1.x ([#32](https://github.com/mParticle/mparticle-apple-media-sdk/pull/32))
- **mParticle Core SDK v9 required**: Minimum `mParticle-Apple-SDK` raised from `~> 8.37` to `~> 9.0` ([#32](https://github.com/mParticle/mparticle-apple-media-sdk/pull/32))
- **NoLocation variant removed**: The `mParticleMediaNoLocation` CocoaPods subspec and the `mParticle-Apple-Media-SDK-NoLocation` SPM product have been removed. The default `mParticleMedia` subspec is also removed — the pod is now consumed directly without a subspec, and the SDK ships as a single target (equivalent to the previous `NoLocation` behavior) ([#32](https://github.com/mParticle/mparticle-apple-media-sdk/pull/32))

For a complete migration walkthrough with before/after dependency declarations, see the [Migration Guide](MIGRATING.md).
