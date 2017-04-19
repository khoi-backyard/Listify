source 'https://github.com/CocoaPods/Specs'

platform :ios, '9.0'

use_frameworks!

target 'Simple Todo' do
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'NSObject+Rx'
    pod 'RxRealm'
    pod 'NSObject+Rx'
    pod 'Result', '~> 3.0.0'

    pod 'SnapKit', '~> 3.1.0'
    pod 'RealmSwift'
    pod 'MBProgressHUD', '~> 1.0.0'
    pod 'R.swift'
    pod 'SwiftyBeaver'

    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Google/SignIn'
end


# Copy acknowledgements to the Settings.bundle
post_install do | installer |
  require 'fileutils'

  pods_acknowledgements_path = 'Pods/Target Support Files/Pods/Pods-Acknowledgements.plist'
  settings_bundle_path = Dir.glob("**/*Settings.bundle*").first

  if File.file?(pods_acknowledgements_path)
    puts 'Copying acknowledgements to Settings.bundle'
    FileUtils.cp_r(pods_acknowledgements_path, "#{settings_bundle_path}/Acknowledgements.plist", :remove_destination => true)
  end
end

