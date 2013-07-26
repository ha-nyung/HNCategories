Pod::Spec.new do |s|
    s.name      = 'HNCategories'
    s.version   = '0.1.0'
    s.license   = 'MIT'
    s.summary   = 'Categories for NS classes'
    s.homepage  = 'https://github.com/minorblend/HNCategories'
    s.author    = { 'Josh Ha-Nyung Chung' => 'minorblend@gmail.com' }
    s.source    = { :git => 'https://github.com/minorblend/HNCategories' }
    s.osx.source_files = 'NS*.{h,m}'
    s.ios.source_files = 'NS*.{h,m}', 'UI*.{h,m}'
    s.requires_arc = true
    s.library   = 'z'
end