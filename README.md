<img src="https://static.mparticle.com/sdk/mp_logo_black.svg" width="280"><br>

# mParticle Apple Media SDK

Hello! This is the public repo of the mParticle Apple Media SDK. We've built the mParticle platform to take a new approach to web and mobile app data and the platform has grown to support 200+ services and SDKs, including developer tools, analytics, attribution, messaging, and advertising services. mParticle is designed to serve as the connector between all of these services - check out [our site](http://mparticle.com), or hit us at developers@mparticle.com to learn more.

## Documentation

Fully detailed documentation and other information about mParticle Apple SDK can be found at our doc site

-   [Core mParticle SDK](https://docs.mparticle.com/developers/sdk/ios/getting-started)

-   [Media SDK](https://docs.mparticle.com/developers/sdk/ios/media)

# Getting Started

Please be aware that this SDK is built as an extension of and requires the use of the [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk/).

## Get the SDK

The mParticle-Apple-Media-SDK is available via [CocoaPods](https://cocoapods.org/?q=mparticle) or [Swift Package Manager](https://github.com/swiftlang/swift-package-manager). Follow the instructions below based on your preference.

#### CocoaPods

To integrate the Media SDK using CocoaPods, specify it in your Podfile:

```ruby
target '<Your Target>' do
    pod 'mParticle-Apple-Media-SDK', '~> 1.0'
    
    # If you'd like to use a version of the Media SDK that doesn't include any location tracking
    # nor links the CoreLocation framework, use this pod instead:
    # pod 'mParticle-Apple-Media-SDK/mParticleMediaNoLocation', '~> 1.0'
end
```
Configuring your `Podfile` with the statement above will include only the _Core_ mParticle Media SDK.

#### Swift Package Manager

To integrate the SDK using Swift Package Manager, open your Xcode project and click on your project in the file list on the left, click on your Project name in the middle of the window, click on the "Package Dependencies" tab, and click the "+" button underneath the Packages list.

Enter the repository URL `https://github.com/mParticle/mparticle-apple-media-sdk` in the search box on the top right, choose `mparticle-apple-media-sdk` from the list of pacakges, and change "Dependency Rule" to "Up to Next Major Version". Then click the "Add Package" button on the bottom right.

Then choose either the "Package Product" called `mParticle-Apple-Media-SDK`, or if you'd like to use a version of the SDK that doesn't include any location tracking nor links the CoreLocation framework choose `mParticle-Apple-Media-SDK-NoLocation`.

**IMPORTANT:** If you choose the `mParticle-Apple-Media-SDK-NoLocation` package product, you will need to import the SDK using `import mParticle_Apple_Media_SDK_NoLocation` instead of `import mParticle_Apple_Media_SDK` as shown in the rest of the documentation and this README. 

## Include and Initialize the SDK

Below summarizes the major steps to get the Apple Media SDK up and running in a swift app. In addition to the below, we have built a sample app that provides a more in depth look at how to send Media Events to Adobe's Heartbeat Kit. See that [sample app here](https://github.com/mParticle/mparticle-media-samples)

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
    mediaContentId: "1234567",          // Custom media ID
    title: "Funny internet cat video",  // Custom media Title
    duration: 120000,                   // Duration in milliseconds
    contentType: .video,                // Content Type (Video or Audio)
    streamType: .onDemand               // Stream Type (OnDemand, Live, etc.)
)

// OR, optionally exclude ad break time from content time tracking when using `logAdBreakStart` and `logAdBreakEnd`
let mediaSession = MPMediaSession.init(
    coreSDK: mParticle,
    mediaContentId: "1234567",
    title: "Funny internet cat video",
    duration: 120000,
    contentType: .video,
    streamType: .onDemand,
    excludeAdBreaksFromContentTime: true // Optional flag (defaults to false)
)

mediaSession.logMediaSessionStart()
mediaSession.logPlay()

// If you'd like to update playhead position frequently or add custom data to each event you may pass an option object into each log method
let options = Options()
options.currentPlayheadPosition = 48000
options.customAttributes = ["testKey": "testValue"]

mediaSession.logPause(options: options)
```

#### Objective-C

The following example demonstrates how to import and use the Apple Media SDK in an Objective-C project. It shows the correct module and header import statements depending on your build setup.

For apps supporting iOS 8 and above, Apple recommends using the import syntax for **modules** or **semantic import**.

If you are using mParticle as a framework, your import statement will be as follows:

```objective-c
@import mParticle_Apple_Media_SDK;          // Apple recommended syntax, but requires "Enable Modules (C and Objective-C)" in pbxproj
#import <mParticle_Apple_Media_SDK/mParticle_Apple_Media_SDK.h>  // Works when modules are not enabled
#import <mParticle_Apple_Media_SDK-Swift.h>

```

Next, you'll need to start the SDK:

```objective-c
- (BOOL)application:(UIApplication *)application
        didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    MParticleOptions *mParticleOptions = [MParticleOptions optionsWithKey:@"REPLACE ME"
                                                                   secret:@"REPLACE ME"];
    
    //Please see the Identity page for more information on building this object
    MPIdentityApiRequest *request = [MPIdentityApiRequest requestWithEmptyUser];
    request.email = @"email@example.com";
    mParticleOptions.identifyRequest = request;
    mParticleOptions.onIdentifyComplete = ^(MPIdentityApiResult * _Nullable apiResult, NSError * _Nullable error) {
        NSLog(@"Identify complete. userId = %@ error = %@", apiResult.user.userId, error);
    };
    
    [[MParticle sharedInstance] startWithOptions:mParticleOptions];
    
    return YES;
}
```

Please see [Identity](http://docs.mparticle.com/developers/sdk/ios/identity/) for more information on supplying an `MPIdentityApiRequest` object during SDK initialization.

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

