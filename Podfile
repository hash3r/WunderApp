source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'

use_frameworks!

inhibit_all_warnings!


def common_pods
    pod 'PromiseKit', '6.4.0'
    pod 'SwiftyJSON', '4.1.0'
end

target "WunderApp" do
    
    common_pods    
    
    #Network layer
    pod 'Alamofire', '4.7.3'
    pod 'AlamofireObjectMapper', '5.1.0'
    
    pod 'HTTPStatusCodes', '3.2.0'
    
end

target "WunderAppTests" do
    common_pods
    pod 'Quick', '1.3.1'
    pod 'Nimble', '7.1.3'
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
    
    #"Update debug pod settings to speed up build time"
    Dir.glob(File.join("Pods", "**", "Pods*{debug,Private}.xcconfig")).each do |file|
        File.open(file, 'a') { |f| f.puts "\nDEBUG_INFORMATION_FORMAT = dwarf" }
    end
end

