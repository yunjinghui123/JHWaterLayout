Pod::Spec.new do |s|
  s.name         = "JHWaterLayout"
  s.version      = "0.0.1"
  s.summary      = "A flowlayout Class"
  s.homepage     = "https://github.com/yunjinghui123/JHWaterLayout"
  s.license      = "MIT"
  s.author             = { "yunjinghui123" => "1432680302@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/yunjinghui123/JHWaterLayout.git", :tag => s.version }
  s.source_files  = "WaterFlowLayout", "WaterFlowLayout/**/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
