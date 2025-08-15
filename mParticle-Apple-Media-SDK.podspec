Pod::Spec.new do |s|
    s.name             = "mParticle-Apple-Media-SDK"
    s.version          = "1.5.3"
    s.summary          = "mParticle Apple Media SDK"

    s.description      = <<-DESC
                       This is the mParticle Apple Media SDK.
                       DESC

    s.homepage         = "https://www.mparticle.com"
    s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
    s.author           = { "mParticle" => "support@mparticle.com" }
    s.source           = { :git => "https://github.com/mparticle/mparticle-apple-media-sdk.git", :tag => s.version.to_s }
    s.social_media_url = "https://twitter.com/mparticle"

    s.swift_version = '5.0'

    s.ios.deployment_target = "9.0"
    s.tvos.deployment_target = "9.0"
    
    # ---- mParticleMedia ----
    s.subspec 'mParticleMedia' do |ss|
        ss.source_files = [
          'mParticle-Apple-Media-SDK-Shared/**/*.{h,m,mm,swift}',
          'mParticle-Apple-Media-SDK/mParticle_Apple_Media_SDK.h'
        ]
        ss.public_header_files = 'mParticle-Apple-Media-SDK/mParticle_Apple_Media_SDK.h'
        ss.dependency 'mParticle-Apple-SDK/mParticle', '~> 8.22'
    end

    # ---- NoLocation ----
    s.subspec 'NoLocation' do |ss|
        ss.pod_target_xcconfig = {
            # ObjC/C/C++: makes MP_NO_LOCATION available to your headers/ObjC code
            'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) MP_NO_LOCATION=1',
            # Swift: lets you use `#if MP_NO_LOCATION` in Swift files
            'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) MP_NO_LOCATION'
        }

        ss.source_files = [
          'mParticle-Apple-Media-SDK-Shared/**/*.{h,m,mm,swift}',
          'mParticle-Apple-Media-SDK/mParticle_Apple_Media_SDK_NoLocation.h'
        ]
        ss.public_header_files = 'mParticle-Apple-Media-SDK/mParticle_Apple_Media_SDK.h'
        ss.dependency 'mParticle-Apple-SDK/mParticleNoLocation', '~> 8.22'
    end
    
    s.default_subspecs = "mParticleMedia"
end
