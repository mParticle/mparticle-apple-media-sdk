<img src="https://static.mparticle.com/sdk/mp_logo_black.svg" width="280"><br>

# mParticle Apple Media SDK

Hello! This is the public repo of the mParticle Apple Media SDK. We've built the mParticle platform to take a new approach to web and mobile app data and the platform has grown to support 200+ services and SDKs, including developer tools, analytics, attribution, messaging, and advertising services. mParticle is designed to serve as the connector between all of these services - check out [our site](http://mparticle.com), or hit us at developers@mparticle.com to learn more.

## Documentation

Fully detailed documentation and other information about mParticle Apple SDK can be found at our doc site

-   [Core mParticle SDK](https://docs.mparticle.com/developers/sdk/ios/getting-started)

-   [Media SDK](https://docs.mparticle.com/developers/sdk/ios/media)

# Getting Started

Please be aware that this SDK is built as an extension of and requires the use of the [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk/).

## Include and Initialize the SDK

Below summarizes the major steps to get the Apple Media SDK up and running. In addition to the below, we have built a sample app that provides a more in depth look at how to send Media Events to Adobe's Heartbeat Kit. See that [sample app here](https://github.com/mParticle/mparticle-media-samples)

### Load mParticle via your app's Podfile or Cartfile:

```ruby
pod 'mParticle-Apple-Media-SDK', '~> 1.0'
```

OR

```ogdl
github "mparticle/mparticle-apple-media-sdk" ~> 1.0
```

```swift
// AppDelegate.swift
import mParticle_Apple_SDK
import mParticle_Apple_Media_SDK

let options = MParticleOptions(key: "REPLACEME", secret: "REPLACEME")
let mParticle = MParticle.sharedInstance()
mParticle.start(with: options)

// Later in your code, when a user begins to engage with your content
let mediaSession = MPMediaSession.init(
    coreSDK: mParticle,                 // mParticle SDK Instance
    mediaContentId: '1234567',          // Custom media ID
    title: 'Funny internet cat video',  // Custom media Title
    duration: 120000,                   // Duration in milliseconds
    contentType: .video,                // Content Type (Video or Audio)
    streamType: .onDemand)              // Stream Type (OnDemand, Live, etc.)
    mediaSession.mediaSessionAttributes = [
        "my_session_attribute": "My Session Attribute"
    ] // Optional custom media session attributes


mediaSession.logMediaSessionStart()
mediaSession.logPlay()

// If you'd like to update playhead position frequently or add custom data to each event you may pass an option object into each log method
let options = Options()
options.currentPlayheadPosition = 48000
options.customAttributes = ["testKey": "testValue"]

mediaSession.logPause(options: options)
```

### Custom media session attributes

You can create custom media session attributes when initializing a new media session by including the custom media session attributes object directly in `MPMediaSession.init`:

```swift
mediaSession.mediaSessionAttributes = [
    "my_session_attribute": "My Session Attribute"
]
```

Custom session attributes have the following limitations:

* 100 key/value pairs per media session
* Keys must be strings and cannot exceed 255 characters
* Values may be strings, numbers, booleans, or dates, and cannot exceed 4096 characters

# Contribution Guidelines

At mParticle, we are proud of our code and like to keep things open source. If you'd like to contribute, simply fork this repo, push any code changes to your fork, and submit a Pull Request against the `master` branch of mParticle-apple-media-sdk.

## Running the Tests

You can use `xcodebuild` from the command line or just `Product > Test` (Command-U) in Xcode.

## SwiftLint

By default Xcode will add trailing whitespace on whitespace only lines, which causes SwiftLint to fail.
You can work around this without changing Xcode settings by running `swiftlint autocorrect` before committing.

## Support

<support@mparticle.com>

## License

The mParticle Apple Media SDK is available under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0). See the LICENSE file for more info.

