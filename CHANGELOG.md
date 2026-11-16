# 项目进展

## 1.0.3 - 2026-11-16 播放、请求与可维护性

- 构建号 `1.0.3+5`。CI 只打 arm64 安装包，测试和打包并行，并缓存 Gradle 与 Android NDK
- 播放：预加载地址绑定歌曲 id，切歌不会套用上一首的链接；连续失败会停住，不再无限跳歌；恢复队列时校正下标，并记下当前歌曲 id
- 播放：进度不再每个采样都刷新通知栏；删除队列项会复制列表并写回本地；随机模式会持久化
- 歌词：两位时间按厘秒解析，同一行多个时间戳会拆开；`//` 空行和元数据行按预期处理
- 首页：单个接口失败不再丢掉其余数据；相似歌曲并行请求；打开歌单不再把首页打成加载中
- 请求：公开接口 3 分钟内存缓存，登录、用户数据和播放地址不缓存；下拉刷新会绕过缓存。调试日志跟随 debug 模式
- 歌词先显示本地缓存，切歌后丢弃过期响应。评论会保留置顶和热门，不再被最新评论清掉
- 扫码登录不会在重建时反复轮询，并在页面销毁或超时后停止
- 歌单当前歌曲高亮改为比较 id。封面按显示尺寸解码
- Android release 规则改为忽略缺失的 Play Core，Gradle 拉取依赖失败会重试。CI 固定 Flutter 3.50.0 / JDK 21，pull request 不再打 nightly 标签
- 补充歌词、播放下标和缓存策略的单元测试，以及 `CONTRIBUTING.md`
- 依赖：`chewie` 1.17.4、`package_info_plus` 10.2.2；移除未使用的 `shimmer`。`google_fonts` 9 与 `build_runner` 2.17 会和当前代码生成器冲突，暂不升级

## 1.0.2 - 2026-11-16 深度适配

- 依赖升至当前可解析的维护版本：auto_route 11、get_it 9、hive_ce、easy_refresh 4、cached_network_image 4、dots_indicator 5
- 移除未使用的 go_router / connectivity_plus，用 hive_ce 替换停更的 hive
- Android edge-to-edge、通知与媒体前台服务权限；iOS 后台音频说明
- 替换 withOpacity、废弃导航 API；analyze 无 error / warning
- README 补充 NeteaseCloudMusicApi 自建步骤

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
