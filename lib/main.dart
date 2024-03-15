import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_project/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

// we always make our app to be a stateless wudget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}
