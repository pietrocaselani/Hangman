Pod::Spec.new do |s|
  s.name             = 'Hangman'
  s.version          = '1.0.41'
  s.summary          = 'A simple pod library for hangman game'

  s.description      = 'A simple hangman game library implemented using TDD just to learn more about it, and also try things like Fastlane, Travis and other stuff that all cool kids are using'

  s.homepage         = 'https://github.com/pietrocaselani/Hangman'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pietro Caselani' => 'pc1992@gmail.com' }
  s.source           = { :git => 'https://github.com/pietrocaselani/Hangman.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pietropc_'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Hangman/**/*'
end
