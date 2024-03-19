Pod::Spec.new do |s|
  s.name     = 'HelpfulKit'
  s.version  = '1.1.2'
  s.platform = :ios, '12.0'
  s.summary  = 'HelpfulKit pod creation for iOS'
  s.description = 'Helpful Extension, Structures and Classes'
  s.homepage = 'https://github.com/DipakPanchasara/HelpfulKit.git'
  s.author   = { 'Dipak Panchasara' => 'panchasara.dipak@gmail.com' }
  s.source   = { :git => 'https://github.com/DipakPanchasara/HelpfulKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.source_files = 'HelpfulKit/*.*'
  s.resource_bundles = {
     'HelpfulKit' => ['HelpfulKit/Resources/*.*']
  }
  s.swift_versions = '5.0'
  s.framework = 'UIKit'
end
