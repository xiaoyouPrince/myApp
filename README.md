# myApp

本项目为一个空 iOS 项目模板，集成常用库，可快速开始项目。

> Note:
> 本项目旨在避免每次写一个小 Demo，或者开始新项目时一切从零开始
> 在一个集成了基础常用库的项目中，配置好基础设置，可有效节省准备时间，
> 让开发者可以更集中精力到业务的开发和问题的解决，从而提升效率

### 使用方式

1. clone 到本地
2. 打开项目，修改项目名称为自己项目名，随后修改 pch 文件路径。
3. 设置项目最低适配版本，如果最低适配 iOS 9+ ，建议在 Main.storyboard 和 LaunchScreen.storyboard 中选中 Use Safe Area Layout Guides
4. cocoaPods 使用

### 概况

本项目创建于 2019年11月17日

- Xcode 版本为 11.2.1
- 最低适配版本为 iOS 8.0 **建议使用者根据自己实际情况调整**
- iOS 13 版本之后开始引入 UISense 概念，App 启动逻辑开始变得不同，需要开发者注意


本项目集成的常用库：

- JPush 推送
- Umeng 统计，分析
- MJExtension
- MJRefresh
- 微信(支付、分享、三方登录)
- 支付宝支付
- 高德地图(地图搜索功能集成6.9.0之后最新的，原因是 iOS 13 之后旧版本地理反编码回调不走，这个坑已处理)
- AFNetworking
- SDWebImage
- Masonry
- SDScrollView
- FMDB




