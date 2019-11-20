Pod::Spec.new do |s|
  s.name         = "IDPSlider"
  s.version      = "0.0.4"
  s.summary      = "IDPSlider is Slider UI for iOS7 and later."

  s.description  = <<-DESC
                   IDPSlider provides a slider user interface simple. Slider you can choose from two types of slim size and normal size. support iOS7 SDK or later.
                   DESC

  s.homepage     = "https://github.com/notoroid/IDPSlider"
  s.screenshots  = "https://raw.githubusercontent.com/notoroid/IDPSlider/master/ScreenShot/ss01.png"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "notoroid" => "noto@irimasu.com" }
  s.social_media_url   = "http://twitter.com/notoroid"

  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/notoroid/IDPSlider.git", :tag => "v0.0.4" }

  s.source_files  = "Lib/**/*.{h,m}"
  s.public_header_files = "Lib/**/*.h"
  s.requires_arc = true
end
