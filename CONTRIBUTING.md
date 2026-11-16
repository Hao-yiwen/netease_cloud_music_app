# 参与开发

## 环境

和 README 相同：Flutter 3.50.0、Dart `>=3.8.0 <4.0.0`、JDK 21。Android 构建使用仓库里的 Gradle 9.5.0 和 AGP 9.3.1。

如果本机有多个 JDK，Flutter 不会自动跟随 Android Studio 的设置，需要指定：

```bash
flutter config --jdk-dir /path/to/jdk-21
```

`.fvmrc` 指向 Flutter `stable`。CI 固定为 3.50.0，本地也建议使用这个版本，避免分析器和 Gradle 插件行为不一致。

## 常用命令

```bash
flutter pub get
flutter analyze --no-fatal-infos --no-fatal-warnings
flutter test
flutter build apk --debug
```

`test/` 里覆盖歌词时间、播放列表下标和 HTTP 缓存白名单。改这三块时请补对应用例。

生成 JSON 和路由代码：

```bash
dart run build_runner build --delete-conflicting-outputs
```

只在改了 `@JsonSerializable` 或 `@RoutePage` 之后需要重新生成。`*.g.dart` 和 `*.gr.dart` 已纳入版本库。

## 接口

应用请求的是兼容 [NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi) 的服务，不直连网易云。默认地址和自建方式见 README。

可以缓存的路径写在 `lib/http/cache_policy.dart`。登录、验证码、用户歌单、红心列表、私人 FM 和歌曲播放地址不能放进去。

## 播放

`MusicHandler` 负责队列、循环和预加载。预加载结果带歌曲 id，只有 id 一致才会拿来播放。进度条的刷新在 `RoamingController`，间隔是 200 到 500 毫秒，不要改回微秒。

## 提交

- 使用约定式提交：`feat`、`fix`、`chore`、`docs`、`refactor`、`test`
- 改了用户能感知的行为时更新 `CHANGELOG.md`
- 保持改动集中，避免顺手重命名大范围文件
