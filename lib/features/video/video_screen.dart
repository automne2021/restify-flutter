import 'package:flutter/material.dart';
import 'package:restify_flutter/shared/widgets/watermark.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // WebView Controller
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(kColorWhite)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            if (mounted) setState(() => _isLoading = false);
          },
          // Block navigation to non-YouTube URLs
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://m.youtube.com')) {
              return NavigationDecision.navigate;
            }
            // Block other URLs
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://m.youtube.com'));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: kColorWhite,
      body: SafeArea(
        child: Watermark(
          child: Stack(
            children: [
              // WEBVIEW
              WebViewWidget(controller: _controller),

              // LOADING INDICATOR
              if (_isLoading)
                const Center(
                  child: CircularProgressIndicator(color: kColorOrange),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
