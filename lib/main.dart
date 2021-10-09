import 'package:flutter/material.dart';

import 'package:maps/routes/routes.dart';
import 'package:maps/screens/loading_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps App',
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
