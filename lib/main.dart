import 'package:flutter/material.dart';

import 'package:reddit_client_7_3_21/src/pages/posts_page.dart';
void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit client',
      debugShowCheckedModeBanner: false,
      home: PostPage(),
      routes: {
        "PostsPage" : (BuildContext context) => PostPage(),
      },
    );
  }
}

