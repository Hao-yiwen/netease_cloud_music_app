// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_service/audio_service.dart' as _i19;
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:netease_cloud_music_app/pages/about.dart' as _i1;
import 'package:netease_cloud_music_app/pages/comment/comment.dart' as _i2;
import 'package:netease_cloud_music_app/pages/empty_page.dart' as _i3;
import 'package:netease_cloud_music_app/pages/error_page.dart' as _i4;
import 'package:netease_cloud_music_app/pages/found/found.dart' as _i5;
import 'package:netease_cloud_music_app/pages/home/home.dart' as _i6;
import 'package:netease_cloud_music_app/pages/login/login.dart' as _i7;
import 'package:netease_cloud_music_app/pages/main/main.dart' as _i8;
import 'package:netease_cloud_music_app/pages/message/message.dart' as _i9;
import 'package:netease_cloud_music_app/pages/new_songs/news_songs.dart'
    as _i10;
import 'package:netease_cloud_music_app/pages/search/search.dart' as _i11;
import 'package:netease_cloud_music_app/pages/songs_list/songs_list.dart'
    as _i12;
import 'package:netease_cloud_music_app/pages/splash/splash_page.dart' as _i13;
import 'package:netease_cloud_music_app/pages/timeline/timeline.dart' as _i14;
import 'package:netease_cloud_music_app/pages/user/user.dart' as _i15;
import 'package:netease_cloud_music_app/pages/webview/webview.dart' as _i16;

/// generated route for
/// [_i1.About]
class About extends _i17.PageRouteInfo<void> {
  const About({List<_i17.PageRouteInfo>? children})
      : super(
          About.name,
          initialChildren: children,
        );

  static const String name = 'About';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.About();
    },
  );
}

/// generated route for
/// [_i2.CommentPage]
class CommentRoute extends _i17.PageRouteInfo<CommentRouteArgs> {
  CommentRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          CommentRoute.name,
          args: CommentRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CommentRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<CommentRouteArgs>(orElse: () => const CommentRouteArgs());
      return _i2.CommentPage(key: args.key);
    },
  );
}

class CommentRouteArgs {
  const CommentRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'CommentRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.EmptyPage]
class EmptyRoute extends _i17.PageRouteInfo<void> {
  const EmptyRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i3.EmptyPage();
    },
  );
}

/// generated route for
/// [_i4.ErrorPage]
class ErrorRoute extends _i17.PageRouteInfo<void> {
  const ErrorRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i4.ErrorPage();
    },
  );
}

/// generated route for
/// [_i5.Found]
class Found extends _i17.PageRouteInfo<void> {
  const Found({List<_i17.PageRouteInfo>? children})
      : super(
          Found.name,
          initialChildren: children,
        );

  static const String name = 'Found';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.Found();
    },
  );
}

/// generated route for
/// [_i6.Home]
class Home extends _i17.PageRouteInfo<void> {
  const Home({List<_i17.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.Home();
    },
  );
}

/// generated route for
/// [_i7.Login]
class Login extends _i17.PageRouteInfo<void> {
  const Login({List<_i17.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.Login();
    },
  );
}

/// generated route for
/// [_i8.Main]
class Main extends _i17.PageRouteInfo<void> {
  const Main({List<_i17.PageRouteInfo>? children})
      : super(
          Main.name,
          initialChildren: children,
        );

  static const String name = 'Main';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.Main();
    },
  );
}

/// generated route for
/// [_i9.MessagePage]
class MessageRoute extends _i17.PageRouteInfo<void> {
  const MessageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessageRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.MessagePage();
    },
  );
}

/// generated route for
/// [_i10.NewsSongs]
class NewsSongs extends _i17.PageRouteInfo<void> {
  const NewsSongs({List<_i17.PageRouteInfo>? children})
      : super(
          NewsSongs.name,
          initialChildren: children,
        );

  static const String name = 'NewsSongs';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.NewsSongs();
    },
  );
}

/// generated route for
/// [_i11.Search]
class Search extends _i17.PageRouteInfo<void> {
  const Search({List<_i17.PageRouteInfo>? children})
      : super(
          Search.name,
          initialChildren: children,
        );

  static const String name = 'Search';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.Search();
    },
  );
}

/// generated route for
/// [_i12.SongsList]
class SongsList extends _i17.PageRouteInfo<SongsListArgs> {
  SongsList({
    _i18.Key? key,
    required List<_i19.MediaItem> songs,
    required String title,
    required String picUrl,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SongsList.name,
          args: SongsListArgs(
            key: key,
            songs: songs,
            title: title,
            picUrl: picUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'SongsList';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SongsListArgs>();
      return _i12.SongsList(
        key: args.key,
        songs: args.songs,
        title: args.title,
        picUrl: args.picUrl,
      );
    },
  );
}

class SongsListArgs {
  const SongsListArgs({
    this.key,
    required this.songs,
    required this.title,
    required this.picUrl,
  });

  final _i18.Key? key;

  final List<_i19.MediaItem> songs;

  final String title;

  final String picUrl;

  @override
  String toString() {
    return 'SongsListArgs{key: $key, songs: $songs, title: $title, picUrl: $picUrl}';
  }
}

/// generated route for
/// [_i13.SplashPage]
class SplashRoute extends _i17.PageRouteInfo<void> {
  const SplashRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashPage();
    },
  );
}

/// generated route for
/// [_i14.Timeline]
class Timeline extends _i17.PageRouteInfo<void> {
  const Timeline({List<_i17.PageRouteInfo>? children})
      : super(
          Timeline.name,
          initialChildren: children,
        );

  static const String name = 'Timeline';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.Timeline();
    },
  );
}

/// generated route for
/// [_i15.User]
class User extends _i17.PageRouteInfo<void> {
  const User({List<_i17.PageRouteInfo>? children})
      : super(
          User.name,
          initialChildren: children,
        );

  static const String name = 'User';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.User();
    },
  );
}

/// generated route for
/// [_i16.WebViewPage]
class WebViewRoute extends _i17.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i18.Key? key,
    required String url,
    required String title,
    bool isHideTitle = false,
    List<_i17.PageRouteInfo>? children,
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

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i16.WebViewPage(
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

  final _i18.Key? key;

  final String url;

  final String title;

  final bool isHideTitle;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, isHideTitle: $isHideTitle}';
  }
}
