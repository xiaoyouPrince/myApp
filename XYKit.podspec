
Pod::Spec.new do |s|
  s.name                     = 'XYKit'
  s.version                  = '0.1.0'
  s.summary                  = '工作中总结的快速开发工具包'
  s.description              = <<-DESC
                                       这是一个快速开发工具包，总结了很多开发中通用的工具、系统分类、和一些方法。
    旨在开发原生项目时候能快速上手且避免重复造轮子。
                               DESC

  s.homepage                 = 'https://github.com/xiaoyouPrince/myApp'
  s.license                  = { :type => 'MIT', :file => './LICENSE' }
  s.author                   = { 'xiaoyouPrince' => 'xiaoyouPrince@163.com' }
  s.source                   = { :git => 'https://github.com/xiaoyouPrince/myApp.git', :tag => s.version.to_s }

  s.ios.deployment_target     = '8.0'
  s.requires_arc             = true
  
  s.swift_version = '5.0'
  s.module_name = 'XYKit'

  s.source_files             = 'myApp/XYTools/**/*.{h,m,xib}'
#  s.resource = [
#  'myApp/Assets/**/*.{xib,plist,bundle,storyboard,json,mp3,jpg,png,mp4}',
#    'myApp/Classes/**/*.{xib,plist,bundle,storyboard,json,mp3,jpg,png,mp4}'
#  ]

  s.dependency 'Masonry'
  s.dependency 'AFNetworking'
  s.dependency 'FMDB'
  s.dependency 'MJExtension'
end
