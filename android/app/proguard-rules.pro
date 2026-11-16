-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
# Flutter 引擎会引用旧版 Play Core，但应用没有接入。-keep 会要求这些类存在，
# release 混淆因此失败。只忽略缺失告警。
-dontwarn com.google.android.play.core.**