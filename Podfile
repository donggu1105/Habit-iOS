# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

target 'habit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'LSHContributionView'
  pod 'JJFloatingActionButton'
  pod 'PContributionsView'
  pod 'SwiftEntryKit', '2.0.0'
  pod 'Google-Mobile-Ads-SDK'
  # Pods for habit

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end

end
