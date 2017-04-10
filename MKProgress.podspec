
Pod::Spec.new do |s|
  s.name         = 'MKProgress'
  s.version      = '1.0.5'
  s.summary      = 'An iOS Progress HUD written in Swift'
  s.description  = <<-DESC
                    A simple progress HUD written in Swift.
                   DESC

  s.homepage     = 'https://github.com/kamirana4/MKProgress'
  s.screenshots  = 'https://github.com/kamirana4/MKProgress/blob/master/_PNG/1.png', 'https://github.com/kamirana4/MKProgress/blob/master/_PNG/2.png', 'https://github.com/kamirana4/MKProgress/blob/master/_PNG/3.png'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Muhammad Kamran' => 'https://github.com/kamirana4' }
  #s.social_media_url   = 'https://www.facebook.com/kamran.fac'
  s.platform     = :ios, '9.0'
  s.source       = { :git => 'https://github.com/kamirana4/MKProgress.git', :tag => s.version }
  s.source_files  = 'MKProgress/*.{swift,plist}'
  # s.resource  = 'icon.png'
  # s.resources = 'Resources/*.png'

end
