# 项目进展

## 1.0.1 - 2026-11-16 维护性升级

- 对齐 Flutter 3.50 / Dart 3.14 稳定工具链
- 升级 Android：Gradle 9.5.0、AGP 9.3.1、Kotlin 2.4.20、compileSdk/targetSdk 36、minSdk 24
- 升级 iOS 最低版本至 15.0
- 更新主要 Dart 依赖，处理 dio_cache_interceptor / just_audio / dots_indicator 等 breaking changes
- 移除已废弃的 Play Core 依赖与过时 Manifest 配置
- 修复 DioException 映射、废弃 API 调用等阻碍构建的问题
- 补充 README 环境要求与运行说明

## 0.0.1 - 2024-09-16 简略正常使用版本，基础功能完成
- 0817：goRouter -> autoRouter
- 0820: 底部粘性播放器
    - 粘性播放器的实现是各个页面都包裹一个底部播放器，然后使用Hero Animation实现播放器的丝滑切换
- 0822: 实现网易云音乐我的页面中头部下拉底部图片拉伸效果，并且附带头部渐变效果
- 0908: 封装网易云音乐图片请求专用组件，解决部分情况下图片403问题
