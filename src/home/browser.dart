import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  Browser({Key key, this.url, this.title, this.showTitle}) : super(key: key);

  String url;
  String title;
  String showTitle;

  @override
  State<StatefulWidget> createState() => BrowserState();
}

class BrowserState extends State<Browser> {
  Widget build(BuildContext context) {
    print(widget.showTitle);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.showTitle),
      ),
      body: _buildWebview(),
    );
  }

  Widget _buildWebview() {
    WebView webview = WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) async {
        widget.showTitle = widget.title;
        // widget.title = await WebViewController.evaluateJavascript("window.document.title");
        setState(() => {});
      }
    );
    return webview;
  }
}
