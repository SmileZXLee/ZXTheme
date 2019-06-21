Pod::Spec.new do |s|
s.name         = 'ZXTheme'
s.version      = '1.0.0'
s.summary      = '零侵入修改全局主题'
s.homepage     = 'https://github.com/SmileZXLee/ZXTheme'
s.license      = 'MIT'
s.authors      = {'李兆祥' => '393727164@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/SmileZXLee/ZXTheme.git', :tag => s.version}
s.source_files = 'ZXThemeDemo/ZXThemeDemo/ZXTheme/**/*'
s.requires_arc = true
end