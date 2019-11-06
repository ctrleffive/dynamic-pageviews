import 'package:flutter/material.dart';

import 'package:dynamic_pageviews/src/views/root.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootPage(),
    );
  }
}