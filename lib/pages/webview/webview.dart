import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:netease_cloud_music_app/routes/routes.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool isHideTitle;

  WebViewPage(
      {Key? key,
      required this.url,
      required this.title,
      this.isHideTitle = false})
      : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xffffffff))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          if (!_isLoading) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        onPageFinished: (String url) {
          if (_isLoading) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isHideTitle
          ? null // 如果 `isHideTitle` 为 true，则不显示 AppBar
          : AppBar(
              title: Text(widget.title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (await _controller.canGoBack()) {
                    _controller.goBack();
                  } else {
                    // 你可以在这里处理无法返回的情况
                    GetIt.instance<AppRouter>().canPop()
                        ? GetIt.instance<AppRouter>().popUntilRoot()
                        : null;
                  }
                },
              ),
            ),
      body: PopScope(
        onPopInvoked: (didPop) async {
          if (await _controller.canGoBack()) {
            _controller.goBack();
          } else {
            GetIt.instance<AppRouter>().canPop()
                ? GetIt.instance<AppRouter>().popUntilRoot()
                : null;
          }
        },
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
