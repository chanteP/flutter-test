import 'package:flutter/material.dart';
import 'src/home/index.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RSS',
      home: new RSSList(),
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}
