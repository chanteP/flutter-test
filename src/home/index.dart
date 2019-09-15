import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'feed.dart';
import 'package:xml2json/xml2json.dart'; // add this line
import 'subscribe.dart';

class RSSList extends StatefulWidget {
  @override
  createState() => RSSListState();
}

class RSSListState extends State<RSSList> {
  final _feedList = <Map>[];

  RSSListState() {
    _requestFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSS@' +
            (DateTime.now().month).toString() +
            '月' +
            (DateTime.now().day).toString() +
            '日'),
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildFeedList(),
    );
  }

  Widget _buildFeedList() {
    return ListView.builder(
        itemCount: _feedList.length,
        itemBuilder: (context, i) {
          return Feed(_feedList[i]);
        });
  }

  _requestFeeds() async {
    const host = subscribeHost;
    subscribeList.forEach((url) {
      _requestFeed(host + url);
    });
  }

  _requestFeed(String url) async {
    Response response = await Dio().get(url).catchError((e) {
      print(e);
    });
    if (response.statusCode != 200 || response.data[0] != '<') {
      return;
    }

    Xml2Json xml2json = new Xml2Json(); //Make an instance.
    xml2json.parse(response.data);
    String jsonData = xml2json.toGData();
    Map data = json.decode(jsonData);

    if (data['rss']['channel'] != null &&
        data['rss']['channel']['item'] != null) {
      var groupName = data['rss']['channel']['title'];
      List<dynamic> items = data['rss']['channel']['item'];
      items.forEach((item) {
        item['group'] = groupName;
        setState(() {
          _feedList.add(item);
        });
      });
    }
  }
}
