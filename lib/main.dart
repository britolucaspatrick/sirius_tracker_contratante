import 'package:flutter/material.dart';
import 'package:sirius_tracker_contratante/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sirius Tracker - Contratante',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),

    );
  }
}



