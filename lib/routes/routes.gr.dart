// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_service/audio_service.dart' as _i21;
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;
import 'package:netease_cloud_music_app/pages/about.dart' as _i1;
import 'package:netease_cloud_music_app/pages/comment/comment.dart' as _i2;
import 'package:netease_cloud_music_app/pages/empty_page.dart' as _i3;
import 'package:netease_cloud_music_app/pages/error_page.dart' as _i4;
import 'package:netease_cloud_music_app/pages/found/found.dart' as _i5;
import 'package:netease_cloud_music_app/pages/home/home.dart' as _i6;
import 'package:netease_cloud_music_app/pages/login/login.dart' as _i7;
import 'package:netease_cloud_music_app/pages/main/main.dart' as _i8;
import 'package:netease_cloud_music_app/pages/message/message.dart' as _i9;
import 'package:netease_cloud_music_app/pages/mv_player/mv_player.dart' as _i10;
import 'package:netease_cloud_music_app/pages/new_songs/news_songs.dart'
    as _i11;
import 'package:netease_cloud_music_app/pages/search/search.dart' as _i12;
import 'package:netease_cloud_music_app/pages/search/search_detail.dart'
    as _i13;
import 'package:netease_cloud_music_app/pages/songs_list/songs_list.dart'
    as _i14;
import 'package:netease_cloud_music_app/pages/splash/splash_page.dart' as _i15;
import 'package:netease_cloud_music_app/pages/timeline/timeline.dart' as _i16;
import 'package:netease_cloud_music_app/pages/user/user.dart' as _i17;
import 'package:netease_cloud_music_app/pages/webview/webview.dart' as _i18;

/// generated route for
/// [_i1.About]
class About extends _i19.PageRouteInfo<void> {
  const About({List<_i19.PageRouteInfo>? children})
      : super(
          About.name,
          initialChildren: children,
        );

  static const String name = 'About';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i1.About();
    },
  );
}

/// generated route for
/// [_i2.CommentPage]
class CommentRoute extends _i19.PageRouteInfo<CommentRouteArgs> {
  CommentRoute({
    _i20.Key? key,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          CommentRoute.name,
          args: CommentRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CommentRoute';

  static _i19.PageInfo page = _i19.PageInfo(
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

  final _i20.Key? key;

  @override
  String toString() {
    return 'CommentRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.EmptyPage]
class EmptyRoute extends _i19.PageRouteInfo<void> {
  const EmptyRoute({List<_i19.PageRouteInfo>? children})
      : super(
          EmptyRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i3.EmptyPage();
    },
  );
}

/// generated route for
/// [_i4.ErrorPage]
class ErrorRoute extends _i19.PageRouteInfo<void> {
  const ErrorRoute({List<_i19.PageRouteInfo>? children})
      : super(
          ErrorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ErrorRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.ErrorPage();
    },
  );
}

/// generated route for
/// [_i5.Found]
class Found extends _i19.PageRouteInfo<void> {
  const Found({List<_i19.PageRouteInfo>? children})
      : super(
          Found.name,
          initialChildren: children,
        );

  static const String name = 'Found';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i5.Found();
    },
  );
}

/// generated route for
/// [_i6.Home]
class Home extends _i19.PageRouteInfo<void> {
  const Home({List<_i19.PageRouteInfo>? children})
      : super(
          Home.name,
          initialChildren: children,
        );

  static const String name = 'Home';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.Home();
    },
  );
}

/// generated route for
/// [_i7.Login]
class Login extends _i19.PageRouteInfo<void> {
  const Login({List<_i19.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.Login();
    },
  );
}

/// generated route for
/// [_i8.Main]
class Main extends _i19.PageRouteInfo<void> {
  const Main({List<_i19.PageRouteInfo>? children})
      : super(
          Main.name,
          initialChildren: children,
        );

  static const String name = 'Main';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i8.Main();
    },
  );
}

/// generated route for
/// [_i9.MessagePage]
class MessageRoute extends _i19.PageRouteInfo<void> {
  const MessageRoute({List<_i19.PageRouteInfo>? children})
      : super(
          MessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MessageRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i9.MessagePage();
    },
  );
}

/// generated route for
/// [_i10.MvPlayer]
class MvPlayer extends _i19.PageRouteInfo<MvPlayerArgs> {
  MvPlayer({
    _i20.Key? key,
    required String title,
    required int id,
    required String artist,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          MvPlayer.name,
          args: MvPlayerArgs(
            key: key,
            title: title,
            id: id,
            artist: artist,
          ),
          initialChildren: children,
        );

  static const String name = 'MvPlayer';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MvPlayerArgs>();
      return _i10.MvPlayer(
        key: args.key,
        title: args.title,
        id: args.id,
        artist: args.artist,
      );
    },
  );
}

class MvPlayerArgs {
  const MvPlayerArgs({
    this.key,
    required this.title,
    required this.id,
    required this.artist,
  });

  final _i20.Key? key;

  final String title;

  final int id;

  final String artist;

  @override
  String toString() {
    return 'MvPlayerArgs{key: $key, title: $title, id: $id, artist: $artist}';
  }
}

/// generated route for
/// [_i11.NewsSongs]
class NewsSongs extends _i19.PageRouteInfo<void> {
  const NewsSongs({List<_i19.PageRouteInfo>? children})
      : super(
          NewsSongs.name,
          initialChildren: children,
        );

  static const String name = 'NewsSongs';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i11.NewsSongs();
    },
  );
}

/// generated route for
/// [_i12.Search]
class Search extends _i19.PageRouteInfo<void> {
  const Search({List<_i19.PageRouteInfo>? children})
      : super(
          Search.name,
          initialChildren: children,
        );

  static const String name = 'Search';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i12.Search();
    },
  );
}

/// generated route for
/// [_i13.SearchDetail]
class SearchDetail extends _i19.PageRouteInfo<SearchDetailArgs> {
  SearchDetail({
    _i20.Key? key,
    List<_i19.PageRouteInfo>? children,
  }) : super(
          SearchDetail.name,
          args: SearchDetailArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SearchDetail';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SearchDetailArgs>(orElse: () => const SearchDetailArgs());
      return _i13.SearchDetail(key: args.key);
    },
  );
}

class SearchDetailArgs {
  const SearchDetailArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'SearchDetailArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.SongsList]
class SongsList extends _i19.PageRouteInfo<SongsListArgs> {
  SongsList({
    _i20.Key? key,
    required List<_i21.MediaItem> songs,
    required String title,
    required String picUrl,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SongsListArgs>();
      return _i14.SongsList(
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

  final _i20.Key? key;

  final List<_i21.MediaItem> songs;

  final String title;

  final String picUrl;

  @override
  String toString() {
    return 'SongsListArgs{key: $key, songs: $songs, title: $title, picUrl: $picUrl}';
  }
}

/// generated route for
/// [_i15.SplashPage]
class SplashRoute extends _i19.PageRouteInfo<void> {
  const SplashRoute({List<_i19.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.SplashPage();
    },
  );
}

/// generated route for
/// [_i16.Timeline]
class Timeline extends _i19.PageRouteInfo<void> {
  const Timeline({List<_i19.PageRouteInfo>? children})
      : super(
          Timeline.name,
          initialChildren: children,
        );

  static const String name = 'Timeline';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i16.Timeline();
    },
  );
}

/// generated route for
/// [_i17.User]
class User extends _i19.PageRouteInfo<void> {
  const User({List<_i19.PageRouteInfo>? children})
      : super(
          User.name,
          initialChildren: children,
        );

  static const String name = 'User';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i17.User();
    },
  );
}

/// generated route for
/// [_i18.WebViewPage]
class WebViewRoute extends _i19.PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    _i20.Key? key,
    required String url,
    required String title,
    bool isHideTitle = false,
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WebViewRouteArgs>();
      return _i18.WebViewPage(
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

  final _i20.Key? key;

  final String url;

  final String title;

  final bool isHideTitle;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, isHideTitle: $isHideTitle}';
  }
}
