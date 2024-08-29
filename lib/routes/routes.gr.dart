// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:netease_cloud_music_app/pages/about.dart' as _i1;
import 'package:netease_cloud_music_app/pages/empty_page.dart' as _i2;
import 'package:netease_cloud_music_app/pages/found/found.dart' as _i3;
import 'package:netease_cloud_music_app/pages/home/home.dart' as _i4;
import 'package:netease_cloud_music_app/pages/login/login.dart' as _i5;
import 'package:netease_cloud_music_app/pages/main/main.dart' as _i6;
import 'package:netease_cloud_music_app/pages/new_songs/news_songs.dart' as _i7;
import 'package:netease_cloud_music_app/pages/search/search.dart' as _i8;
import 'package:netease_cloud_music_app/pages/splash/splash_page.dart' as _i9;
import 'package:netease_cloud_music_app/pages/timeline/timeline.dart' as _i10;
import 'package:netease_cloud_music_app/pages/user/user.dart' as _i11;
import 'package:netease_cloud_music_app/pages/webview/webview.dart' as _i12;

/// generated route for
/// [_i1.About]
class About extends _i13.PageRouteInfo<void> {
  const About({List<_i13.PageRouteInfo>? children})
      : super(
          About.name,
          initialChildren: children,
        );

  static const String name = 'About';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.About();
    },
  );
}

/// generated route for
/// [_i2.EmptyPage]
class EmptyRoute extends _i13.PageRouteInfo<void> {
  const EmptyRoute({List<_i13.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i2.EmptyPage();
    },
  );
}

/// generated route for
/// [_i3.Found]
class Found extends _i13.PageRouteInfo<void> {
  const Found({List<_i13.PageRouteInfo>? children})
      : super(
          Found.name,
          initialChildren: children,
        );

  static const String name = 'Found';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.Found();
    },
  );
}

/// generated route for
/// [_i4.Home]
class Home extends _i13.PageRouteInfo<void> {
  const Home({List<_i13.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.Home();
    },
  );
}

/// generated route for
/// [_i5.Login]
class Login extends _i13.PageRouteInfo<void> {
  const Login({List<_i13.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.Login();
    },
  );
}

/// generated route for
/// [_i6.Main]
class Main extends _i13.PageRouteInfo<void> {
  const Main({List<_i13.PageRouteInfo>? children})
      : super(
          Main.name,
          initialChildren: children,
        );

  static const String name = 'Main';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.Main();
    },
  );
}

/// generated route for
/// [_i7.NewsSongs]
class NewsSongs extends _i13.PageRouteInfo<void> {
  const NewsSongs({List<_i13.PageRouteInfo>? children})
      : super(
          NewsSongs.name,
          initialChildren: children,
        );

  static const String name = 'NewsSongs';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.NewsSongs();
    },
  );
}

/// generated route for
/// [_i8.Search]
class Search extends _i13.PageRouteInfo<void> {
  const Search({List<_i13.PageRouteInfo>? children})
      : super(
          Search.name,
          initialChildren: children,
        );

  static const String name = 'Search';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.Search();
    },
  );
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashPage();
    },
  );
}

/// generated route for
/// [_i10.Timeline]
class Timeline extends _i13.PageRouteInfo<void> {
  const Timeline({List<_i13.PageRouteInfo>? children})
      : super(
          Timeline.name,
          initialChildren: children,
        );

  static const String name = 'Timeline';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.Timeline();
    },
  );
}

/// generated route for
/// [_i11.User]
class User extends _i13.PageRouteInfo<void> {
  const User({List<_i13.PageRouteInfo>? children})
      : super(
          User.name,
          initialChildren: children,
        );

  static const String name = 'User';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.User();
    },
  );
}

/// generated route for
/// [_i12.WebViewPage]
class WebViewRoute extends _i13.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i14.Key? key,
    required String url,
    required String title,
    bool isHideTitle = false,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          WebViewRoute.name,
          args: WebViewRouteArgs(
            key: key,
            url: url,
            title: title,
            isHideTitle: isHideTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'WebViewRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i12.WebViewPage(
        key: args.key,
        url: args.url,
        title: args.title,
        isHideTitle: args.isHideTitle,
      );
    },
  );
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.url,
    required this.title,
    this.isHideTitle = false,
  });

  final _i14.Key? key;

  final String url;

  final String title;

  final bool isHideTitle;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, isHideTitle: $isHideTitle}';
  }
}
