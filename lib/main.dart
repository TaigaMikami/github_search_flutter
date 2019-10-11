import 'package:flutter/material.dart';
import 'package:github_search/github_search_home.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "GitHub Search",
      debugShowCheckedModeBanner: false,
      home: new GithubSearchHome(),
    );
  }
}
