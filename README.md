# 网易云音乐 Flutter 版

![Flutter](https://img.shields.io/badge/flutter-v3.24.1-blue)
![iOS](https://img.shields.io/badge/iOS-12.0+-lightgrey)
![Android](https://img.shields.io/badge/Android-6.0+-brightgreen)

## 项目概述

基于 Flutter 开发的网易云音乐第三方客户端，完整还原官方 App 用户体验。使用 Flutter SDK 3.24.1，基于网易云音乐 9.1.55 版本开发。

### 技术栈

- **状态管理**: GetX
- **依赖注入**: GetIt  
- **路由管理**: GoRouter/AutoRouter
- **后端接口**: [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)

## 扫码下载

<img src="showcase/android_v1.0.0.png" width="30%" />

### 快速开始

1. 运行项目:
```bash
flutter run -d <your-device>
```
注：服务部署在 Vercel，如遇高延迟建议本地部署

2. 使用手机号码和短信验证码登录

### 已知问题

- 部分页面因多接口数据整合可能加载较慢，优化中

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