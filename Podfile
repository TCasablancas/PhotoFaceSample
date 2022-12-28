# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

target 'PhotoFaceSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
#  pod 'PartnerOneSDK', :path => "../PartnerOneSDK"
  pod 'Alamofire', '~> 4.7'
  pod 'ObjectMapper', '~> 3.5'
  pod 'PartnerOneSDK', :git => "https://github.com/partneroneti/p1sdk.ios.git", :branch => 'fix/code-cleaning'

  # Pods for PhotoFaceSample

  target 'PhotoFaceSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PhotoFaceSampleUITests' do
    # Pods for testing
  end

end
