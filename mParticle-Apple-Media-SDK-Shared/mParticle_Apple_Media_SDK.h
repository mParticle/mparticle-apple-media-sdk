#import <UIKit/UIKit.h>

//! Project version number for mParticle_Apple_Media_SDK
FOUNDATION_EXPORT double mParticle_Apple_Media_SDKVersionNumber;

//! Project version string for mParticle_Apple_Media_SDK.
FOUNDATION_EXPORT const unsigned char mParticle_Apple_Media_SDKVersionString[];

#if defined(__has_include) && __has_include(<mParticle_Apple_SDK/mParticle.h>)
  // Framework distribution: CocoaPods, Carthage, XCFramework
  #import <mParticle_Apple_SDK/mParticle.h>
#elif defined(__has_include) && __has_include(<mParticle_Apple_SDK_ObjC/mParticle.h>)
  // SPM 9.x: ObjC headers live in the mParticle_Apple_SDK_ObjC target
  #import <mParticle_Apple_SDK_ObjC/mParticle.h>
#else
  // SPM 8.x: mParticle_Apple_SDK was an ObjC module, @import works
  @import mParticle_Apple_SDK;
#endif
