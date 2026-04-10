<!-- markdownlint-disable MD024 -->

# Migration Guides

This document provides migration guidance for breaking changes in the mParticle Apple Media SDK.

## Migrating from versions < 2.0.0

### Increased Minimum Deployment Target

The minimum supported deployment targets have been raised.

#### What Has Changed

- **iOS**: 12.0 → 15.6
- **tvOS**: 12.0 → 15.6

#### Migration Steps

If your app targets iOS or tvOS below 15.6, you must remain on v1.x of the Media SDK. Otherwise, update your project's deployment target to iOS 15.6 / tvOS 15.6 or later.

---

### mParticle Core SDK v9 Required

The Media SDK now requires mParticle Apple SDK v9.0 or later.

#### What Has Changed

- The minimum required version of `mParticle-Apple-SDK` has changed from `~> 8.37` to `~> 9.0`.

#### Migration Steps

Update your dependency declaration to reference v9:

**CocoaPods:**

```ruby
# Before
pod 'mParticle-Apple-SDK', '~> 8.0'

# After
pod 'mParticle-Apple-SDK', '~> 9.0'
```

**Swift Package Manager:**

```swift
// Before
.package(url: "https://github.com/mParticle/mparticle-apple-sdk", from: "8.0.0")

// After
.package(url: "https://github.com/mParticle/mparticle-apple-sdk", from: "9.0.0")
```

If you have not already migrated to the mParticle Apple SDK v9, follow the [core SDK migration guide](https://github.com/mParticle/mparticle-apple-sdk/blob/main/MIGRATING.md) before updating the Media SDK.

---

### Removed NoLocation Variant

The `NoLocation` build variant has been removed. The SDK now ships as a single target, which no longer includes location support — equivalent to what the `NoLocation` variant previously provided.

#### What Has Changed

- The `mParticleMediaNoLocation` CocoaPods subspec has been removed
- The `mParticle-Apple-Media-SDK-NoLocation` SPM product has been removed
- The default CocoaPods subspec (`mParticleMedia`) has been removed — the pod is now consumed directly without a subspec

#### Migration Steps

**CocoaPods:**

```ruby
# Before
pod 'mParticle-Apple-Media-SDK/mParticleMedia', '~> 1.0'
# or
pod 'mParticle-Apple-Media-SDK/mParticleMediaNoLocation', '~> 1.0'

# After
pod 'mParticle-Apple-Media-SDK', '~> 2.0'
```

**Swift Package Manager:**

```swift
// Before
.product(name: "mParticle-Apple-Media-SDK-NoLocation", package: "mParticle-Apple-Media-SDK")
// or
.product(name: "mParticle-Apple-Media-SDK", package: "mParticle-Apple-Media-SDK")

// After
.product(name: "mParticle-Apple-Media-SDK", package: "mParticle-Apple-Media-SDK")
```
