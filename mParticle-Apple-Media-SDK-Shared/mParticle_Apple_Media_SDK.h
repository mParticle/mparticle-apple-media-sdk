#import <UIKit/UIKit.h>

//! Project version number for mParticle_Apple_Media_SDK
FOUNDATION_EXPORT double mParticle_Apple_Media_SDKVersionNumber;

//! Project version string for mParticle_Apple_Media_SDK.
FOUNDATION_EXPORT const unsigned char mParticle_Apple_Media_SDKVersionString[];

#if defined(__has_include) && __has_include(<mParticle_Apple_SDK/mParticle.h>)
  // Framework distribution: CocoaPods, Carthage, XCFramework
  #import <mParticle_Apple_SDK/mParticle.h>
#else
  // SPM: import the ObjC target directly via its generated module map.
  // mParticle_Apple_SDK_ObjC is the ObjC target in both 8.x and 9.x; its
  // module map is always passed via -fmodule-map-file by Xcode.
  @import mParticle_Apple_SDK_ObjC;
#endif
