Pod::Spec.new do |s|
  s.name             = 'TanDeferred'
  s.version          = '0.1.0'
  s.summary          = 'A little `Functional` & `Reactive` programming library.'
 
  s.homepage         = 'https://github.com/TangentW/Deferred'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tangent' => '805063400@qq.com' }
  s.source           = { :git => 'https://github.com/TangentW/Deferred.git', :tag => s.version.to_s }
 
  s.source_files = 'Deferred/Deferred/**/*.{h,m}'
 
end