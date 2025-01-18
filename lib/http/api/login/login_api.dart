import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music_app/http/api/bean.dart';
import 'package:netease_cloud_music_app/http/http.dart';
import 'package:netease_cloud_music_app/http/http_utils.dart';
import 'package:netease_cloud_music_app/http/api/login/dto/login_status_dto.dart';

class LoginApi {
  static Future<LoginStatusDto> loginWithPhone(
      {required String phone,
      String? password = '',
      String? captcha = ''}) async {
    String? countryCode;
    if (phone.startsWith('+')) {
      // Split with space
      final parts = phone.split(' ');
      if (parts.length == 2) {
        countryCode = parts[0].substring(1); // Remove the +
        phone = parts[1];
      }
    }
    final params = {
      'phone': phone,
      if (captcha?.isNotEmpty == true)
        'captcha': captcha
      else
        'password': password,
      if (countryCode != null) 'countrycode': countryCode,
    };
    final res = await HttpUtils.get('/login/cellphone', params: params);
    var info = LoginStatusDto.fromJson(res);
    Http().usc.onLogined(info);

    return info;
  }

  static Future<ServerStatusBean> captcha(String phone) async {
    String? countryCode;
    if (phone.startsWith('+')) {
      // Split with space
      final parts = phone.split(' ');
      if (parts.length == 2) {
        countryCode = parts[0].substring(1); // Remove the +
        phone = parts[1];
      }
    }
    final params = {
      'phone': phone,
      if (countryCode != null) 'ctcode': countryCode,
    };
    final res = await HttpUtils.get('/captcha/sent', params: params);
    return ServerStatusBean.fromJson(res);
  }

  static Future<LoginStatusDto> loginWithEmail(
      {required String email, required String password}) async {
    final data = {
      'email': email,
      'password': password,
    };
    final res = await HttpUtils.post('/login',
        params: {
          "time": DateTime.now().millisecondsSinceEpoch,
        },
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        )
    );
    var info = LoginStatusDto.fromJson(res);
    Http().usc.onLogined(info);

    return info;
  }

  static Future<(String, Image)> getLoginQr() async {
    final res = await HttpUtils.get('/login/qr/key', params: {
      "t": DateTime.now().millisecondsSinceEpoch
    });
    String key = res['data']['unikey'];
    final res2 = await HttpUtils.get('/login/qr/create', params: {
      "key": key,
      "qrimg": "true"
    });
    String qr = res2['data']['qrimg'];
    var parts = qr.split(",");
    qr = parts[1];
    return (key, Image.memory(base64Decode(qr)));
  }

  static Future<bool?> checkQrLoginStatus(String key) async {
    final res = await HttpUtils.get('/login/qr/check', params: {
      "key": key,
      "t": DateTime.now().millisecondsSinceEpoch
    });
    switch (res['code']){
      case 800:
        return false;
      case 801:
        return null;
      case 802:
        return null;
      case 803:
        return true;
      default:
        return false;
    }
  }

  static Future<LoginStatusDto> loginStatus() async {
    final res = await HttpUtils.get('/login/status');
    var info = LoginStatusDto.fromJson(res['data']);
    Http().usc.onLogined(info);
    return info;
  }

  static Future<void> logout() async {
    await HttpUtils.get('/logout');
    Http().usc.onLogout();
  }
}
