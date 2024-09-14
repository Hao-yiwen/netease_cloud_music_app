# 仿网易云音乐项目

![Flutter](https://img.shields.io/badge/flutter-v3.24.1-blue)

## 项目运行

此项目还在不断完善中，目前离v1版本还有一定距离，欢迎大家提出宝贵意见。

1. 启动后端服务，端口默认3000
   - git clone https://gitlab.com/Binaryify/neteasecloudmusicapi.git
   - npm i
   - node app.js 
2. 启动该项目，目前只支持短信验证码登录

## 展示

<img src="show_example.png" width="32%">

## 项目介绍

flutter版本网易云音乐

- 仿照网易云音乐版本 9.1.55

- flutter开发版本: 3.24.1

- 后端接口：https://github.com/Binaryify/NeteaseCloudMusicApi

- 参考项目：
    - https://github.com/2697a/bujuan autoroute
    - https://gitee.com/master_xing/flutter_cloud_music 底部粘性播放条实现

- 技术栈：getx, getit, gorouter/autoRouter

## 项目进展

- 0817：goRouter -> autoRouter
- 0820: 底部粘性播放器
    - 粘性播放器的实现是各个页面都包裹一个底部播放器，然后使用Hero Animation实现播放器的丝滑切换
- 0822: 实现网易云音乐我的页面中头部下拉底部图片拉伸效果，并且附带头部渐变效果
- 0908: 封装网易云音乐图片请求专用组件，解决部分情况下图片403问题

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Hao-yiwen/netease_cloud_music_app&type=Date)](https://star-history.com/#Hao-yiwen/netease_cloud_music_app)