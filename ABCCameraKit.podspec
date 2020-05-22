Pod::Spec.new do |s|
  s.name             = "ABCCameraKit"
  s.version          = "0.0.1"
  s.summary          = "ABCCameraKit"
  s.description      = "ABCCameraKit of 杭州笔声智能科技有限公司"
  s.homepage         = "https://www.abcpen.com"
  s.license          = 'MIT'
  s.author           = { "bing" => "bing@abcpen.com" }
  s.source           = { :git => 'https://github.com/abcpen-inc/ABCCameraKit.git',:tag => s.version}
  s.platform         = :ios, '10.0'
  s.requires_arc     = true

 s.subspec 'ABCCommonKit' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCCommonKit.framework/Headers/ABCCommonKit.h'
    sp.source_files        = 'ABCCameraKit/ABCCommonKit.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCCommonKit.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end
  
  s.subspec 'ABCCameraKit' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCCameraKit.framework/Headers/ABCCameraKit.h'
    sp.source_files        = 'ABCCameraKit/ABCCameraKit.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCCameraKit.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end

 s.subspec 'ABCDetector' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCDetector.framework/Headers/ABCDetector.h'
    sp.source_files        = 'ABCCameraKit/ABCDetector.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCDetector.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end

  s.subspec 'ABCPDFKit' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCPDFKit.framework/Headers/ABCPDFKit.h'
    sp.source_files        = 'ABCCameraKit/ABCPDFKit.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCPDFKit.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end

  s.subspec 'ABCAuthKit' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCAuthKit.framework/Headers/ABCAuthKit.h'
    sp.source_files        = 'ABCCameraKit/ABCAuthKit.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCAuthKit.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end

  s.subspec 'ABCOpenCVImageKit' do |sp|
    sp.public_header_files = 'ABCCameraKit/ABCOpenCVImageKit.framework/Headers/ABCOpenCVImageKit.h'
    sp.source_files        = 'ABCCameraKit/ABCOpenCVImageKit.framework/Headers/*.{h}'
    sp.vendored_frameworks = 'ABCCameraKit/ABCOpenCVImageKit.framework'
    sp.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  end
  
end
