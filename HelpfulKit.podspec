Pod::Spec.new do |s|
  s.name     = "HelpfulKit"
  s.version  = "0.1.2"
  s.platform = :ios, "11.0"
  s.summary  = "HelpfulKit pod creation for iOS"
  s.description = "Helpful Extension, Structures and Classes"
  s.homepage = "https://github.com/DipakPanchasara/HelpfulKit.git"
  s.author   = { "Dipak Panchasara" => "panchasara.dipak@gmail.com" }
  s.source   = { :git => "https://github.com/DipakPanchasara/HelpfulKit.git", :tag => "0.1.2" }
  s.ios.deployment_target = "10.0"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source_files = "HelpfulKit/*"
  s.swift_versions = "5.0"
end
