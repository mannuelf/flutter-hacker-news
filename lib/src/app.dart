import 'package:flutter/material.dart';

import 'screens/news_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return const MaterialApp(
      title: 'News List',
      home: NewsList(),
    );
  }
}
