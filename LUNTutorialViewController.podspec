Pod::Spec.new do |s|
  s.name         = 'LUNTutorialViewController'
  s.version      = '1.0.0'
  s.summary      = 'UIViewController designed to simplify creation of tutorial/onboarding of your iOS application'
  s.description  = 'UIViewController designed to simplify creation of tutorial/onboarding of your iOS application.'
  s.screenshots  = 'https://i1.wp.com/lunapps.com/blog/wp-content/uploads/2016/04/5_scaled-1.gif?zoom=2&resize=500%2C334&ssl=1'
  s.homepage     = 'https://github.com/LunApps/LUNTutorialViewController'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Vladimir Sharavara' => 'vovasharavara@gmail.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/LunApps/LUNTutorialViewController.git', :tag => '1.0.0' }
  s.source_files = 'LUNTutorialViewController/**/*.{h,m}'
  s.requires_arc = true
end