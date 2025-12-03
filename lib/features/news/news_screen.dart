import 'package:flutter/material.dart';
import 'package:restify_flutter/shared/widgets/watermark.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:restify_flutter/core/theme/app_colors.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
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
            if (request.url.contains('vnexpress.net')) {
              return NavigationDecision.navigate;
            }
            // Block other URLs
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://vnexpress.net'));
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