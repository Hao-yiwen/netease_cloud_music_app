# 网易云音乐 Flutter 版

![Flutter](https://img.shields.io/badge/flutter-v3.50.0-blue)
![Dart](https://img.shields.io/badge/dart-3.8%2B-blue)
![iOS](https://img.shields.io/badge/iOS-15.0+-lightgrey)
![Android](https://img.shields.io/badge/Android-API%2024%2B-brightgreen)

## 项目概述

基于 Flutter 开发的网易云音乐第三方客户端，完整还原官方 App 用户体验。当前维护版本基于 Flutter 3.50 / Dart 3.14 工具链，接口参考网易云音乐 9.1.55。

### 技术栈

- **状态管理**: GetX
- **依赖注入**: GetIt
- **路由管理**: AutoRoute（项目中仍保留 go_router 依赖）
- **后端接口**: [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)

## 环境要求

| 项目 | 版本要求 |
| --- | --- |
| Flutter | 3.50.0（stable）或兼容的当前 stable |
| Dart SDK | `>=3.8.0 <4.0.0` |
| Java (Android 构建) | 17+（推荐 17 / 21） |
| Android | minSdk 24，compileSdk / targetSdk 由 Flutter 工具链提供（当前为 36） |
| iOS | 15.0+（需 macOS + Xcode；Linux 无法构建） |
| Android Gradle Plugin | 9.3.1 |
| Gradle | 9.5.0 |
| Kotlin | 2.4.20 |

可选：若使用 [FVM](https://fvm.app/)，项目 `.fvmrc` 指向 `stable`。

## 快速开始

1. 克隆仓库并进入项目目录：

```bash
git clone https://github.com/Hao-yiwen/netease_cloud_music_app.git
cd netease_cloud_music_app
```

2. 获取依赖：

```bash
flutter pub get
```

3. 连接设备或启动模拟器后运行：

```bash
flutter devices
flutter run -d <your-device>
```

4. 使用手机号码和短信验证码登录。

> 说明：默认 API 部署在 Vercel（`UrlConstants.BASE_URL`）。如遇高延迟或接口不可用，建议本地部署 [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)，并在应用设置中修改 Base URL。

### 常用验证命令

```bash
flutter analyze
flutter test
flutter build apk --debug
```

iOS（仅 macOS）：

```bash
cd ios && pod install && cd ..
flutter build ios --debug --no-codesign
```

## 扫码下载

<img src="showcase/android_v1.0.0.png" width="30%" />

### 已知问题

- 部分页面因多接口数据整合可能加载较慢，优化中
- 第三方 API / 登录验证码依赖外部服务，可用性需自行确认

## 功能状态

### 已完成功能
- 推荐页面 (main)
- 发现页面 (found)
- 漫游页面 (roam)
- 动态页面 (timeline)
- 我的页面 (user)
- 搜索功能
- 歌单页面
- MV 播放
- 评论系统
- 消息中心
- 音乐播放与后台播放
- 歌词显示
- Android 适配
- 网络库优化

### 开发中功能
- 骨架屏加载
- 漫游功能重构
- Loading 效果优化

### 计划功能
- 发布动态
- iOS 小组件
- 缓存策略优化

## 技术参考

- [bujuan](https://github.com/2697a/bujuan): AutoRoute 实现
- [flutter_cloud_music](https://gitee.com/master_xing/flutter_cloud_music): 底部播放控制

## 项目预览

<img src="showcase/show_gif.gif" width="30%" />

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Hao-yiwen/netease_cloud_music_app&type=Date)](https://star-history.com/#Hao-yiwen/netease_cloud_music_app)
