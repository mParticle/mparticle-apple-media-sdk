#import <UIKit/UIKit.h>

//! Project version number for mParticle_Apple_Media_SDK
FOUNDATION_EXPORT double mParticle_Apple_Media_SDKVersionNumber;

//! Project version string for mParticle_Apple_Media_SDK.
FOUNDATION_EXPORT const unsigned char mParticle_Apple_Media_SDKVersionString[];

#if defined(__has_include) && __has_include(<mParticle_Apple_SDK/mParticle.h>)
  #import <mParticle_Apple_SDK/mParticle.h>
#else
  @import mParticle_Apple_SDK;
#endif
