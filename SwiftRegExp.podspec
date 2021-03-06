Pod::Spec.new do |s|
  s.name             = "SwiftRegExp"
  s.version          = "2.0"
  s.summary          = "SwiftyRegExp is a simple and convenient Swift wrapper around NSRegularExpression. It was inspired by Ben Scheirman's \"RegEx in Swift\" post"
  s.homepage         = "https://github.com/glaurent/SwiftRegExp"
  s.license          = 'BSD'
  s.author           = { "Guillaume Laurent" => "glaurent@telegraph-road.org" }
  s.source           = { :git => "https://github.com/glaurent/SwiftRegExp.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "9.3"
  s.osx.deployment_target = "10.10"

  s.source_files = '*.swift'
end
