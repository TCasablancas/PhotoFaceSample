# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

target 'PhotoFaceSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  #pod 'PartnerOneSDK', :path => "../p1sdk.ios"
  pod 'Alamofire', '~> 4.7'
  pod 'ObjectMapper', '~> 3.5'
#  pod 'PartnerOneSDK', :git => "https://github.com/partneroneti/p1sdk.ios.git", :branch => 'bugfix/200823'

  # Pods for PhotoFaceSample

  target 'PhotoFaceSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PhotoFaceSampleUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
