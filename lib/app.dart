import 'package:flutter/material.dart';
import 'screens/main_app.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Balance App',
      theme: AppTheme.lightTheme,
      home: const MainApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
