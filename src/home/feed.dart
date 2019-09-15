import 'package:flutter/material.dart';
import 'browser.dart';

const titleFontStyle =
    const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
const infoFontSize = 14.0;
const infoFontColor = Color(0xff999999);
const infoFontStyle =
    const TextStyle(fontSize: infoFontSize, color: infoFontColor);

// class FeedItem {
//   String author;
//   String description;
//   String from;
//   String fromUrl;
//   String image;
//   String link;
//   String pubDate;
//   String title;
// }

class Feed extends StatefulWidget {
  var feedData;
  Feed(feedData) {
    this.feedData = feedData;
  }
  @override
  createState() => FeedState();
}

class FeedState extends State<Feed> {
  final _titleFontStyle = titleFontStyle;
  final _infoFontStyle = infoFontStyle;

  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _openView,
        child: Card(
          elevation: 1,
          shape: Border(),
          margin: EdgeInsets.only(top: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitle(),
                _buildInfo(),
                _buildDesc(),
              ],
            ),
            padding: EdgeInsets.all(20),
          ),
        ));
  }

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        Expanded(child: Text(_getText('title'), style: _titleFontStyle))
      ],
    );
  }

  Widget _buildInfo() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: <Widget>[
          _buildInfoTag(Icons.label_outline, _getText('group')),
          _buildInfoTag(Icons.timer, _getText('pubDate')),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: Row(children: <Widget>[
          Icon(icon, size: infoFontSize, color: infoFontColor),
          Text(
            text,
            style: _infoFontStyle,
          )
        ]));
  }

  Widget _buildDesc() {
    String desc = _getText('description');
    desc = desc.replaceAll(new RegExp(r'<([\s\S]+?)>'), '');
    desc = desc.length > 100 ? desc.substring(0, 100) + '...' : desc;
    
    return Row(
      children: <Widget>[
        // Icon(Icons.attach_file),
        Expanded(child: Text(desc))
      ],
    );
  }

  void _openView() {
    var url = _getText('link');
    var title = _getText('title');

    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new Browser(
        url: url,
        title: title,
        showTitle: url,
      );
    }));
  }

  String _getText(String key) {
    if (widget.feedData[key] == null) {
      return '';
    }
    return widget.feedData[key]['__cdata'] ?? widget.feedData[key]['\$t'];
  }
}
