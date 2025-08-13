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
    
    s.subspec 'mParticleMedia' do |ss|
      # Include Shared + the sdk symlink contents
      ss.source_files        = 'mParticle-Apple-Media-SDK-Shared/**/*.{h,m,swift}', 'mParticle-Apple-Media-SDK/**/*.{h,m,swift}'
      # Only expose the Location umbrella as public
      ss.public_header_files = 'mParticle-Apple-Media-SDK/mParticle_Apple_Media_SDK.h'
      # Make sure we do NOT accidentally pull the NoLocation umbrella here
      ss.exclude_files       = 'mParticle-Apple-Media-SDK-NoLocation/**/*'
      ss.dependency 'mParticle-Apple-SDK/mParticle', '~> 8.22'
    end

    s.subspec 'mParticleMediaNoLocation' do |ss|
      # Include Shared + the nolocation symlink contents
      ss.source_files        = 'mParticle-Apple-Media-SDK-Shared/**/*.{h,m,swift}', 'mParticle-Apple-Media-SDK-NoLocation/**/*.{h,m,swift}'
      # Only expose the NoLocation umbrella as public
      ss.public_header_files = 'mParticle-Apple-Media-SDK-NoLocation/mParticle_Apple_Media_SDK_NoLocation.h'
      # Make sure we do NOT accidentally pull the Location umbrella here
      ss.exclude_files       = 'mParticle-Apple-Media-SDK/**/*'
      ss.dependency 'mParticle-Apple-SDK/mParticleNoLocation', '~> 8.22'
    end

end
