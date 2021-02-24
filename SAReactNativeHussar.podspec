
Pod::Spec.new do |s|
  s.name         = "SAReactNativeHussar"
  s.version      = "0.0.1"
  s.summary      = "Sensors Analytics React Native Plugin debug tools"
  s.description  = <<-DESC
                  神策分析 React Native 组件 调试工具
                   DESC
  s.homepage     = "http://www.sensorsdata.cn"
  s.license      = { :type => "Apache License, Version 2.0" }
  s.author       = { "Yuanyang Peng" => "pengyuanyang@sensorsdata.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/sensorsdata/react-native-sensors-analytics.git", :tag => "v#{s.version}" }
  s.source_files = "ios/SAReactNativeHussar/*.{h,m}"
  s.requires_arc = true
  s.dependency   "React"

end

