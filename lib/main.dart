import 'package:agri_tonaton/core/utils/app.dart';
import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri Tonaton',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY),
      ),
      home: Splash()
    );
  }
}
