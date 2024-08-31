// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:netease_cloud_music_app/http/api/main/dto/recommend_songs_dto.dart'
    as _i16;
import 'package:netease_cloud_music_app/pages/about.dart' as _i1;
import 'package:netease_cloud_music_app/pages/empty_page.dart' as _i2;
import 'package:netease_cloud_music_app/pages/found/found.dart' as _i3;
import 'package:netease_cloud_music_app/pages/home/home.dart' as _i4;
import 'package:netease_cloud_music_app/pages/login/login.dart' as _i5;
import 'package:netease_cloud_music_app/pages/main/main.dart' as _i6;
import 'package:netease_cloud_music_app/pages/new_songs/news_songs.dart' as _i7;
import 'package:netease_cloud_music_app/pages/search/search.dart' as _i8;
import 'package:netease_cloud_music_app/pages/songs_list/songs_list.dart'
    as _i9;
import 'package:netease_cloud_music_app/pages/splash/splash_page.dart' as _i10;
import 'package:netease_cloud_music_app/pages/timeline/timeline.dart' as _i11;
import 'package:netease_cloud_music_app/pages/user/user.dart' as _i12;
import 'package:netease_cloud_music_app/pages/webview/webview.dart' as _i13;

/// generated route for
/// [_i1.About]
class About extends _i14.PageRouteInfo<void> {
  const About({List<_i14.PageRouteInfo>? children})
      : super(
          About.name,
          initialChildren: children,
        );

  static const String name = 'About';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.About();
    },
  );
}

/// generated route for
/// [_i2.EmptyPage]
class EmptyRoute extends _i14.PageRouteInfo<void> {
  const EmptyRoute({List<_i14.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i2.EmptyPage();
    },
  );
}

/// generated route for
/// [_i3.Found]
class Found extends _i14.PageRouteInfo<void> {
  const Found({List<_i14.PageRouteInfo>? children})
      : super(
          Found.name,
          initialChildren: children,
        );

  static const String name = 'Found';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.Found();
    },
  );
}

/// generated route for
/// [_i4.Home]
class Home extends _i14.PageRouteInfo<void> {
  const Home({List<_i14.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.Home();
    },
  );
}

/// generated route for
/// [_i5.Login]
class Login extends _i14.PageRouteInfo<void> {
  const Login({List<_i14.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.Login();
    },
  );
}

/// generated route for
/// [_i6.Main]
class Main extends _i14.PageRouteInfo<void> {
  const Main({List<_i14.PageRouteInfo>? children})
      : super(
          Main.name,
          initialChildren: children,
        );

  static const String name = 'Main';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.Main();
    },
  );
}

/// generated route for
/// [_i7.NewsSongs]
class NewsSongs extends _i14.PageRouteInfo<void> {
  const NewsSongs({List<_i14.PageRouteInfo>? children})
      : super(
          NewsSongs.name,
          initialChildren: children,
        );

  static const String name = 'NewsSongs';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.NewsSongs();
    },
  );
}

/// generated route for
/// [_i8.Search]
class Search extends _i14.PageRouteInfo<void> {
  const Search({List<_i14.PageRouteInfo>? children})
      : super(
          Search.name,
          initialChildren: children,
        );

  static const String name = 'Search';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.Search();
    },
  );
}

/// generated route for
/// [_i9.SongsList]
class SongsList extends _i14.PageRouteInfo<SongsListArgs> {
  SongsList({
    _i15.Key? key,
    required _i16.RecommendSongsDto recommendSongsDto,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SongsList.name,
          args: SongsListArgs(
            key: key,
            recommendSongsDto: recommendSongsDto,
          ),
          initialChildren: children,
        );

  static const String name = 'SongsList';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SongsListArgs>();
      return _i9.SongsList(
        key: args.key,
        recommendSongsDto: args.recommendSongsDto,
      );
    },
  );
}

class SongsListArgs {
  const SongsListArgs({
    this.key,
    required this.recommendSongsDto,
  });

  final _i15.Key? key;

  final _i16.RecommendSongsDto recommendSongsDto;

  @override
  String toString() {
    return 'SongsListArgs{key: $key, recommendSongsDto: $recommendSongsDto}';
  }
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashPage();
    },
  );
}

/// generated route for
/// [_i11.Timeline]
class Timeline extends _i14.PageRouteInfo<void> {
  const Timeline({List<_i14.PageRouteInfo>? children})
      : super(
          Timeline.name,
          initialChildren: children,
        );

  static const String name = 'Timeline';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.Timeline();
    },
  );
}

/// generated route for
/// [_i12.User]
class User extends _i14.PageRouteInfo<void> {
  const User({List<_i14.PageRouteInfo>? children})
      : super(
          User.name,
          initialChildren: children,
        );

  static const String name = 'User';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.User();
    },
  );
}

/// generated route for
/// [_i13.WebViewPage]
class WebViewRoute extends _i14.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i15.Key? key,
    required String url,
    required String title,
    bool isHideTitle = false,
    List<_i14.PageRouteInfo>? children,
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

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i13.WebViewPage(
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

  final _i15.Key? key;

  final String url;

  final String title;

  final bool isHideTitle;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, isHideTitle: $isHideTitle}';
  }
}
