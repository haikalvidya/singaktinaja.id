import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_singkatin/feature/shortlink/shortlink_ui/home_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, this.url}) : super(key: key);

  final String? url;

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Text('Kembali Ke Menu')),
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url!,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
