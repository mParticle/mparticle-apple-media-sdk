Pod::Spec.new do |s|
    s.name             = "mParticle-Apple-Media-SDK"
    s.version          = "1.0.0-beta.1"
    s.summary          = "mParticle Apple Media SDK"

    s.description      = <<-DESC
                       This is the mParticle Apple Media SDK.
                       DESC

    s.homepage         = "https://www.mparticle.com"
    s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
    s.author           = { "mParticle" => "support@mparticle.com" }
    s.source           = { :git => "https://github.com/mparticle/mparticle-apple-media.git", :tag => s.version.to_s }
    s.social_media_url = "https://twitter.com/mparticle"

    s.static_framework = true
    s.swift_version = '5.0'

    s.ios.deployment_target = "9.0"
    s.ios.source_files      = 'mParticle-Apple-Media-SDK/*.{h,swift}'
    s.ios.dependency 'mParticle-Apple-SDK', '~> 7.0'
end
