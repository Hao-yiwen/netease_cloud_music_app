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

4. 打开 App 后优先用扫码登录。短信和邮箱密码仍在登录页，但网易云经常拦截这两种方式。

更完整的构建、分析和测试说明见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 安装后怎么用

1. 从仓库的 Latest Release 下载 `netease-<版本>-arm64.apk`，装到 arm64 真机。
2. 打开后点右上角切换到扫码，用官方网易云 App 扫码。这是目前社区还能走通的登录方式。
3. 如果提示连不上接口，点登录页的「修改接口地址」，或打开侧边栏里的「接口地址」，填入自己的服务根地址，例如 `http://192.168.1.8:3000/`。

短信验证码和邮箱密码仍保留。网易云对这两条路返回 `8821`（需要行为验证码）或 `-462`（人机验证）时，App 会说明原因。公网上的 Vercel 接口更容易触发这些码，换成自己的服务器后再试。

## 网易云音乐 API

应用不直连网易云官方域名，而是请求兼容 [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi) 的服务。扫码登录的修复在维护中的二开 [NeteaseCloudMusicApiEnhanced](https://github.com/NeteaseCloudMusicApiEnhanced/api-enhanced)。

默认地址写在 `lib/common/constants/url.dart` 的 `UrlConstants.BASE_URL`：

`https://neteasecloudmusicapi-one-tan.vercel.app/`

2026-11-16 在维护环境实测该地址的 `/search` 与 `/banner` 返回 `code: 200`。登录不保证可用：维护者在 2026 年仍确认密码登录会被拦，短信登录在公网部署上也会碰到人机验证。该服务部署在第三方 Vercel，可能限流、过期或变更。

### 自建并切换

1. 部署仍在维护登录的二开（Node.js 22+）：

```bash
git clone https://github.com/NeteaseCloudMusicApiEnhanced/api-enhanced.git
cd api-enhanced
pnpm i
node app.js
```

默认监听 `http://127.0.0.1:3000`。真机请改成电脑局域网 IP，并和手机处在同一网络。Android 模拟器访问宿主机用 `http://10.0.2.2:3000`。开发机调试 Android 时也可以 `adb reverse tcp:3000 tcp:3000`，再把接口地址设为 `http://127.0.0.1:3000/`。

2. 在登录页或侧边栏修改接口地址。App 会补上 `http://` 和结尾的 `/`，并写入 SharedPreferences 键 `BASE_URL`。

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

master 上的构建会按 `pubspec.yaml` 的版本名发布正式 Release，并标成仓库的 Latest。当前版本是 `v1.0.4`，安装包文件名是 `netease-1.0.4-arm64.apk`。pull request 只上传 artifact，不发 Release。这个包面向近年真机，不包含 32 位和模拟器 x86_64。安装包从 GitHub Release 获取；这是第三方客户端，不提供应用商店上架。

### 已知问题

- 短信和密码登录依赖网易云风控，公网接口上经常失败；扫码和自建 NeteaseCloudMusicApiEnhanced 是目前可用的办法
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
