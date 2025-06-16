import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(QuranWordsApp());
}

class QuranWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          textStyle: const TextStyle(fontSize: 18),
        ),
      ),
    );
    return MaterialApp(
      title: '500 слов из Корана',
      theme: theme,
      home: HomeScreen(),
    );
  }
}
