import 'package:flutter/material.dart';

import '../http/http_utils.dart';
import 'base_url.dart';
import 'constants/other.dart';
import 'constants/url.dart';

Future<void> showBaseUrlDialog(BuildContext context) async {
  final baseUrl = await UrlConstants.BASE_URL;
  if (!context.mounted) return;
  final urlController = TextEditingController(text: baseUrl);
  try {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('接口地址'),
          content: TextField(
            controller: urlController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '例如 http://192.168.1.8:3000/',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final url = normalizeBaseUrl(urlController.text);
                  await UrlConstants.setBaseUrl(url);
                  await HttpUtils.init(baseUrl: url);
                  if (!dialogContext.mounted) return;
                  Navigator.of(dialogContext).pop();
                  WidgetUtil.showToast('接口地址已更新');
                } on FormatException catch (e) {
                  WidgetUtil.showToast(e.message);
                }
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  } finally {
    urlController.dispose();
  }
}
