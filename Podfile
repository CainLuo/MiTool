inhibit_all_warnings!

target 'MiTool' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  platform :osx, '10.13'
 
  pod 'SwiftLint'

  # Pods for MiTool

  target 'MiToolTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.13'
              end
          end
      end
  end
end
