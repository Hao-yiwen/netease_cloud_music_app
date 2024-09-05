# netease_cloud_music_app

flutter版本网易云音乐

- flutter开发版本: 3.22.3

- 后端接口：https://github.com/Binaryify/NeteaseCloudMusicApi

- 参考项目：
  - https://github.com/2697a/bujuan autoroute
  - https://gitee.com/master_xing/flutter_cloud_music 底部粘性播放条实现

- 技术栈：getx, getit, gorouter/autoRouter

## 项目周期

- 0817：goRouter -> autoRouter
- 0820: 底部粘性播放器
  - 粘性播放器的实现是各个页面都包裹一个底部播放器，然后使用Hero Animation实现播放器的丝滑切换
- 0822: 实现网易云音乐我的页面中头部下拉底部图片拉伸效果，并且附带头部渐变效果