
Pod::Spec.new do |s|
  s.name         = 'MKProgress'
  s.version      = '1.0.8'
  s.summary      = 'An iOS Progress HUD written in Swift'
  s.description  = <<-DESC
                    A simple progress HUD written in Swift.
                   DESC

  s.homepage     = 'https://github.com/kamirana4/MKProgress'
  s.screenshots  = 'https://dl.dropboxusercontent.com/s/601xnyxy76mnugq/Simulator%20Screen%20Shot%20Apr%203%2C%202017%2C%2011.04.49%20PM.png'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'Muhammad Kamran' => 'https://github.com/kamirana4' }
  #s.social_media_url   = 'https://www.facebook.com/kamran.fac'
  s.platform     = :ios, '9.0'
  s.source       = { :git => 'https://github.com/kamirana4/MKProgress.git', :tag => s.version.to_s }
  s.source_files  = 'MKProgress/*.{swift}'
  # s.resource  = 'icon.png'
  # s.resources = 'Resources/*.png'

end
