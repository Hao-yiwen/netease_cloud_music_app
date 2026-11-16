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
- **路由管理**: AutoRoute 11
- **本地缓存**: hive_ce（替代已停止维护的 hive）
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

4. 使用手机号码和短信验证码登录。也可以在登录页切换邮箱或扫码。

更完整的构建、分析和测试说明见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 网易云音乐 API

应用不直连网易云官方域名，而是请求兼容 [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi) 的服务。

默认地址写在 `lib/common/constants/url.dart` 的 `UrlConstants.BASE_URL`：

`https://neteasecloudmusicapi-one-tan.vercel.app/`

2026-11-16 在维护环境实测该地址可访问，`/search` 与 `/banner` 返回 `code: 200`。该服务部署在第三方 Vercel，可能限流、过期或变更，不能当作长期保证。

### 使用默认服务

直接 `flutter run`。登录页使用手机号 + 短信验证码，依赖上述 API 的 `/captcha/sent`、`/login/cellphone` 等接口。

### 自建并切换

1. 部署 API（Node.js 18+）：

```bash
git clone https://github.com/Binaryify/NeteaseCloudMusicApi.git
cd NeteaseCloudMusicApi
npm install
node app.js
```

默认监听 `http://127.0.0.1:3000`。真机调试时请改成电脑局域网 IP，并保证手机与电脑同一网络。Android 模拟器访问宿主机可用 `http://10.0.2.2:3000`。

2. 在 App 侧边栏设置里修改 Base URL，或在首次启动前写入 SharedPreferences 键 `BASE_URL`（需以 `/` 结尾）。代码入口：`UrlConstants.setBaseUrl`。

3. 若接口返回 460 / 301 等风控码，按 NeteaseCloudMusicApi 文档配置 `realIP` 或登录后再请求。

本仓库不包含、也不代理网易云账号数据。

### 常用验证命令

```bash
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter build apk --debug
```

`flutter analyze` 在 Flutter 3.50 上会对 `package:flutter/material.dart` 给出 info 级弃用提示，替换包 `package:material_ui` 还不在当前 SDK 里，因此 CI 不把 info 当成失败。error 仍然会失败。

iOS（仅 macOS）：

```bash
cd ios && pod install && cd ..
flutter build ios --debug --no-codesign
```

## 安装包

master 上的构建会把 arm64 安装包发到 nightly Release，文件名是 `netease-<版本>-<提交>-arm64.apk`。pull request 只上传同名 artifact，不打标签。这个包面向近年真机，不包含 32 位和模拟器 x86_64。

### 已知问题

- 第三方 API / 登录验证码依赖外部服务，可用性需自行确认
- 通知栏上的喜欢按钮还没有接到红心接口
- 首页仍会并发请求多份推荐数据，未登录时部分卡片为空是预期结果

## 代码怎么分

| 目录 | 职责 |
| --- | --- |
| `lib/pages` | 页面和 GetX Controller |
| `lib/http` | Dio、缓存策略和各模块 API |
| `lib/common` | 播放、歌词、主题和通用工具 |
| `lib/widgets` | 跨页面组件 |
| `test` | 不依赖设备的逻辑测试 |

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
