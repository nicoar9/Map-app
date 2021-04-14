import 'package:flutter/material.dart';
import 'package:map_app/pages/gps_access_page.dart';
import 'package:map_app/pages/loading_page.dart';
import 'package:map_app/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: GpsAccessPage(),
      routes: {
        'map': (_) => MapPage(),
        'loading': (_) => LoadingPage(),
        'gps_access': (_) => GpsAccessPage()
      },
    );
  }
}
