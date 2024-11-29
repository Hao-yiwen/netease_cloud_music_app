# 网易云音乐 Flutter 版

![Flutter](https://img.shields.io/badge/flutter-v3.24.1-blue)
![iOS](https://img.shields.io/badge/iOS-12.0+-lightgrey)
![Android](https://img.shields.io/badge/Android-6.0+-brightgreen)



## 项目简介

这是一个使用 Flutter 开发的网易云音乐第三方客户端，致力于还原官方 App 的用户体验。

### 技术特点

- 基于网易云音乐 9.1.55 版本进行开发
- Flutter SDK 版本: 3.24.1
- 后端接口采用开源项目：[NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)
- 核心技术栈：
  - 状态管理：GetX
  - 依赖注入：GetIt
  - 路由管理：GoRouter/AutoRouter

### 参考项目

- [bujuan](https://github.com/2697a/bujuan) - AutoRoute 实现参考
- [flutter_cloud_music](https://gitee.com/master_xing/flutter_cloud_music) - 底部播放控制栏实现

## 快速开始

项目当前已趋于稳定，非常欢迎社区的反馈和建议。

### 环境配置

1. 启动后端服务（默认端口 3000）
   ```bash
   git clone https://gitlab.com/Binaryify/neteasecloudmusicapi.git
   npm install
   node app.js
   ```

2. 运行 Flutter 项目
   ```bash
   flutter run -d <your-device>
   ```

3. 使用手机号码和短信验证码登录即可开始体验

## 已知问题

- 服务器部署的接口目前存在登录稳定性问题，可能出现401登录环境异常的情况。建议在本地启动服务以获得最佳体验。
- 为了优化主页展示效果，部分数据需要调用多个后端接口进行整合，可能导致加载速度较慢。我们正在对此进行优化，以提升用户体验。

## App预览

<img src="showcase/show_gif.gif" width="30%" style="display:inline-block;" />

## 页面预览

- ~~推荐页面 main - 已完成~~
- ~~发现页面 found - 已完成~~
- ~~漫游页面 roam - 已完成~~
- ~~动态页面 timeline - 已完成~~
- ~~我的页面 user - 已完成~~
- ~~搜索页面 search - 已完成~~
- ~~歌单页面 songlist - 已完成~~
- ~~mv页面 mv - 已完成~~
- ~~评论页面 comment - 已完成~~
- ~~消息页面 message - 已完成~~

## 项目规划

### p1

- ~~页面基本复制网易云音乐app页面 - 已完成~~
- ~~音乐播放&后台播放 - 已完成~~
- ~~评论页面 - 已完成~~
- ~~歌词页面 - 已完成(页面很糙)~~
- ~~我的消息页面 - 已完成~~
- ~~搜索页面 - 已完成~~
- 漫游功能重构 - 未开始
- ~~页面样式优化&代码优化 - 已完成~~
- ~~网络库优化 - 已完成~~
- ~~android适配 - 已完成~~
- ~~loading效果收口 - 未开始~~

### p2

- ~~视频播放 - 已完成~~
- 发布动态页面 - 未开始
- ~~骨架屏引入 - 进行中~~
- ios小组件开发 - 未开始
- 缓存策略 - 未开始

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Hao-yiwen/netease_cloud_music_app&type=Date)](https://star-history.com/#Hao-yiwen/netease_cloud_music_app)
