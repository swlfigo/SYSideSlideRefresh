Pod::Spec.new do |s|

  s.name         = "SYSideSlideRefresh"
  s.version      = "1.0.1"
  s.summary      = "ScrollView Side Slide Refresh"

  s.description  = <<-DESC
  					Base on MJRefresh Project Modify, Use For ScrollView Side Slide Refresh. (基于MJRefresh的侧滑控件)
                   DESC

  s.homepage     = "https://github.com/swlfigo/SYSideSlideRefresh"
  s.license      = 'MIT'
  s.author             = { "Sylar" => "swlfigo@gmail.com" }


  s.source       = { :git => "https://github.com/swlfigo/SYSideSlideRefresh.git", :tag => "#{s.version}" }
  s.source_files  = "SYSideSlideRefresh/**/*.{h,m}"

  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'
  s.dependency 'MJRefresh'

end
