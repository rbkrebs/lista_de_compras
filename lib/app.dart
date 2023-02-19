import 'package:flutter/material.dart';

import './views/page_list.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageList(),
      debugShowCheckedModeBanner: false,
    );
  }
}
