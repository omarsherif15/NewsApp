import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
   final String? url;
   final String? name;
  WebViewScreen({this.url,this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: WebView(
        initialUrl: url,

      ),
    );

  }
}
